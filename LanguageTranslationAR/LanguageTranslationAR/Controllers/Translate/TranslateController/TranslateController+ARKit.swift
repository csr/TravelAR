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

extension TranslateController: ARSCNViewDelegate, OnboardingDelegate {
    
    @objc internal func runARSession() {
        print("Running AR session...")
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session = augmentedRealitySession
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
    }
    
    func addNode(translation: Translation, coords: SCNVector3) {
        let currentLanguage = LanguagePreferences.getCurrent()
        let langCode = currentLanguage.code.uppercased()
        if let flagEmoji = Flag(countryCode: langCode)?.emoji {
            customARView.setText(text: flagEmoji + " " + translation.translatedText)
        } else {
            customARView.setText(text: translation.translatedText)
        }
        
        let height: CGFloat = 0.02
        let aspectRatio = customARView.bounds.height / customARView.bounds.width
        let width = height * (1 / aspectRatio)
            
        let plane = SCNPlane(width: width, height: height)
        let imageMaterial = SCNMaterial()
        imageMaterial.diffuse.contents = customARView.asImage()
        
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
        DispatchQueue.main.async {
            if !self.plusButton.isHidden {
                self.updateFocusSquare()
            }
        }
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            self.changeScanningState(planesDetected: true)
        }
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
                    
    func didFinishOnboarding() {
        runARSession()
        setupCoreML()
    }
}

extension TranslateController: ARSessionDelegate {
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        self.processVisionRequests()
    }
}
