//
//  DictionaryController+Actions.swift
//  MirrorProject
//
//  Created by Cesare de Cal on 31/03/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVKit
import ARKit

@available(iOS 11.0, *)
extension DictionaryController {        
    func didTapSceneView(coords: SCNVector3) {
        print("didTapSceneView(coords: SCNVector3)")
        guard let latestPrediction = mlPrediction else { return }
        if !latestPrediction.isEmpty {
            getTranslation(text: latestPrediction) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.addNode(title: latestPrediction, subtitle: translation.translatedText, coords: coords)
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
        print("didTapAddButton")
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
        
        if let coords = detectWorldCoordinates() {
            self.addNode(title: "hello", subtitle: "world", coords: coords)
            //didTapSceneView(coords: coords)
            print("adding node...")
        } else {
            print("coords are nil")
        }
    }
        
    @objc internal func didTapClearScene() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            if node is FocusSquare {
                node.removeFromParentNode()
            }
        }
        
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
    
    @objc func updateLabel() {
        identifier = mlPrediction        
    }
}
