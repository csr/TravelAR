//
//  TranslateController+Actions.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/22/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import ARKit
import EasyTipView

extension TranslateController: ARDetailViewDelegate {
    func didTapReproduce(translation: Translation) {
        TextToSpeech.speak(item: translation)
    }
    
    func didTapClose() {
        self.shouldPresentARDetailView = true
    }
    
    @objc func didTapAddButton() {
        shouldShowToolTip = false
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
        
        guard let result = sceneView.hitTest(position, options: nil).first, let node = result.node as? TranslationNode, let translation = node.translation, shouldPresentARDetailView else {
            return
        }
        
        let detailView = ARDetailView(frame: CGRect(x: position.x, y: position.y, width: 100, height: 40))
        detailView.delegate = self
        detailView.translation = translation
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        UIView.animate(withDuration: 0.2) {
            detailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            detailView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            detailView.widthAnchor.constraint(equalToConstant: 350).isActive = true
            self.shouldPresentARDetailView = false
            self.view.layoutIfNeeded()
        }
    }
    
    func presentTipView() {
        tipView.show(forView: addButton,
                         withinSuperview: view)
    }
    
    @objc func didTapClearButton() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            if node is TranslationNode {
                node.removeFromParentNode()
            }
        }
        
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        
        TextToSpeech.speak(text: "test")
    }
    
    func addNodeTranslation(coords: SCNVector3) {
        if !identifier.isEmpty {
            getTranslation(text: identifier) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.addNode(translation: translation, coords: coords)
                        TranslationItems.shared.array.append(translation)
                    }
                }
            }
        }
    }
}
