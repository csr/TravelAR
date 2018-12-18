//
//  DictionaryController+ARKit.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import ARKit
import Flags

@available(iOS 11.0, *)
extension DictionaryController: ARSCNViewDelegate {

    @objc internal func setupAR() {
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.session = augmentedRealitySession        
    }
    
    func createNode(text: String) -> SCNNode? {
        let currentLanguage = LanguagePreferences.getCurrent()
        let langCode = currentLanguage.languageCode.uppercased()
        if let flagEmoji = Flag(countryCode: langCode)?.emoji {
            customView.textLabel.text = flagEmoji + " " + text
        } else {
            customView.textLabel.text = text
        }
        
        print("custom view frame width:", customView.frame.width)
        print("custom view frame height:", customView.frame.height)

        let height: CGFloat = 0.02
        let aspectRatio = customView.frame.height / customView.frame.width 
        let width = height * (1 / aspectRatio)
        print("aspect ratio:", aspectRatio)
        print("width:", width)
        
        let plane = SCNPlane(width: width, height: height)
        
        print("final width and height:", width, height)
        
        let imageMaterial = SCNMaterial()
        imageMaterial.isDoubleSided = true
        imageMaterial.diffuse.contents = customView.asImage()
        
        plane.materials = [imageMaterial]
        let node = SCNNode(geometry: plane)
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = [.X, .Y, .Z]
        node.constraints = [billboardConstraint]
        
        return node
    }
        
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async { self.updateFocusSquare() }
    }
    
    func updateFocusSquare() {
        if let camera = self.augmentedRealitySession.currentFrame?.camera,
            case .normal = camera.trackingState,
            let result = self.sceneView.smartHitTest(screenCenter) {
            updateQueue.async {
                if self.canDisplayFocusSquare {
                    self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                    self.focusSquare.state = .detecting(hitTestResult: result, camera: camera)
                }
            }
            
        } else {
            updateQueue.async {
                if self.canDisplayFocusSquare {
                    self.focusSquare.state = .initializing
                    self.sceneView.pointOfView?.addChildNode(self.focusSquare)
                }
            }
        }
    }
    
    func didTapSceneView(coords: SCNVector3) {
        print("didTapSceneView(coords: SCNVector3)")
        guard let latestPrediction = mlPrediction else { return }
        if !latestPrediction.isEmpty {
            getTranslation(text: latestPrediction) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.handleIncomingTranslation(translation: translation)
                        TranslationItems.shared.array.append(translation)
                    }
                }
            }
        }
    }
    
    func handleIncomingTranslation(translation: Translation) {
        //self.animateDictionaryView(item: translation)
        TextToSpeech.speak(item: translation)
    }
    
    @objc func didTapAddButton() {
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint]) // Alternatively, we could use '.existingPlaneUsingExtent' for more grounded hit-test-points.
        if let closestResult = arHitTestResults.first, let identifier = identifier {
            let transform: matrix_float4x4 = closestResult.worldTransform
            let worldCoord: SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            
            if let node = createNode(text: identifier) {
                sceneView.scene.rootNode.addChildNode(node)
                node.position = worldCoord
            } else {
                print("ERROR! Something wrong here.")
            }
        }
    }
    
    @objc internal func didTapClearButton() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
    
    @objc func updateLabel() {
        identifier = mlPrediction
        if let identifier = identifier {
            feedbackView.textLabel.text = identifier
            UIView.animate(withDuration: 0.2) {
                self.addButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.addButton.alpha = 0.5
            }
            feedbackView.textLabel.text = "WARNING_NOTHING_FOUND".localized()
        }
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATextLayerAlignmentMode(_ input: CATextLayerAlignmentMode) -> String {
	return input.rawValue
}

// this would be outside your controller class, i.e. the top-level of a swift file
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
