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
import EasyTipView

extension TranslateController: ARSCNViewDelegate {

    @objc internal func runARSession() {
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session = augmentedRealitySession
        sceneView.session.run(configuration)
    }
    
    func addNode(translation: Translation, coords: SCNVector3) {
        view.addSubview(customViewLabel)
        
        
        let customView = CustomView()
//        view.addSubview(customView)
//        customView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        customView.translatesAutoresizingMaskIntoConstraints = false
        print("Custom view frame init:", customView.frame)
        
        let currentLanguage = LanguagePreferences.getCurrent()
        let langCode = currentLanguage.languageCode.uppercased()
        if let flagEmoji = Flag(countryCode: langCode)?.emoji {
            customViewLabel.text = flagEmoji + " " + translation.translatedText
        } else {
            customViewLabel.text = translation.translatedText
        }
        
        print("custom view label width and height:", customViewLabel.frame)

        customView.invalidateIntrinsicContentSize()
        
        print("New label text set for custom view. New frame:", customView.frame)
        
        let height: CGFloat = 0.02
        let aspectRatio = customView.bounds.height / customView.bounds.width
        let width = height * (1 / aspectRatio)
        
        let plane = SCNPlane(width: width, height: height)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = customView.asImage()
        
        plane.materials = [imageMaterial]
        let node = TranslationNode()
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
                
    @objc func updateLabel() {
        if let mlPrediction = mlPrediction {
            translateOriginalText(text: mlPrediction) { (translatedPrediction) in
                if let translatedPrediction = translatedPrediction {
                    self.identifier = translatedPrediction
                    
                    DispatchQueue.main.async {
                        self.feedbackView.textLabel.text = self.identifier
                    }
                }
            }
            
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
