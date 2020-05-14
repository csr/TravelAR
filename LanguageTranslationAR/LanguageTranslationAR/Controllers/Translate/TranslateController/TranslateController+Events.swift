//
//  TranslateController+Events.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/22/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import ARKit
import EasyTipView

extension TranslateController {    
    @objc func didTapAddButton() {
        tipView.dismiss()
        
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint]) // Alternatively, we could use '.existingPlaneUsingExtent' for more grounded hit-test-points.
        if let closestResult = arHitTestResults.first {
            let transform: matrix_float4x4 = closestResult.worldTransform
            let worldCoord: SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            addNodeTranslation(coords: worldCoord)
        }        
    }
    
    func didTouchSceneView(touches: Set<UITouch>, event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: sceneView)
        
        guard let result = sceneView.hitTest(position, options: nil).first, let node = result.node as? TranslationNode, let translation = node.translation, sceneView.alpha == 1 else {
            return
        }
        
        presentDetailView(node: node, translation: translation)
    }
        
    @objc func didTapClearButton() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            if node is TranslationNode {
                node.removeFromParentNode()
            }
        }
        
        // Subtle device vibration if supported
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
    
    func addNodeTranslation(coords: SCNVector3) {
        if !previousObjectPrediction.isEmpty {
            getTranslation(text: previousObjectPrediction) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.addNode(translation: translation, coords: coords)
                        TranslationItems.shared.add(object: translation)
                    }
                }
            }
        }
    }
}
