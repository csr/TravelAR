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

class CustomSCNNode: SCNNode {
    var translation: Translation?
    
}

extension TranslateController: ARSCNViewDelegate {

    @objc internal func runARSession() {
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session = augmentedRealitySession
        sceneView.session.run(configuration)
    }
    
    func addNode(translation: Translation, coords: SCNVector3) {
        let currentLanguage = LanguagePreferences.getCurrent()
        let langCode = currentLanguage.languageCode.uppercased()
        if let flagEmoji = Flag(countryCode: langCode)?.emoji {
            customView.textLabel.text = flagEmoji + " " + translation.translatedText
        } else {
            customView.textLabel.text = translation.translatedText
        }
        
        let height: CGFloat = 0.02
        let aspectRatio = customView.bounds.height / customView.bounds.width
        let width = height * (1 / aspectRatio)
        
        let plane = SCNPlane(width: width, height: height)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = customView.asImage()
        
        plane.materials = [imageMaterial]
        let node = CustomSCNNode()
        node.geometry = plane
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = [.X, .Y, .Z]
        node.constraints = [billboardConstraint]
        node.position = coords
        node.translation = translation
        sceneView.scene.rootNode.addChildNode(node)
    }
        
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async { self.updateFocusSquare() }
    }
    
    func updateFocusSquare() {
        var screenCenter: CGPoint {
            let bounds = self.sceneView.bounds
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
        
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
        if !identifier.isEmpty {
            getTranslation(text: identifier) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.addNode(translation: translation, coords: coords)
                        self.handleIncomingTranslation(translation: translation)
                        TranslationItems.shared.array.append(translation)
                    } else {
                        print("translation is nil!")
                    }
                }
            }
        } else {
            print("identifier is empty!")
        }
    }
    
    func handleIncomingTranslation(translation: Translation) {
        TextToSpeech.speak(item: translation)
    }
    
    @objc func didTapAddButton() {
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint]) // Alternatively, we could use '.existingPlaneUsingExtent' for more grounded hit-test-points.
        if let closestResult = arHitTestResults.first {
            let transform: matrix_float4x4 = closestResult.worldTransform
            let worldCoord: SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            didTapSceneView(coords: worldCoord)
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
        if let mlPrediction = mlPrediction {
            identifier = mlPrediction
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

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
