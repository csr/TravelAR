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
        self.animateDictionaryView(item: translation)
        TextToSpeech.speak(item: translation)        
    }
    
    @objc func didTapAddButton() {
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
        
        if let coords = detectWorldCoordinates() {
            didTapSceneView(coords: coords)
        }
    }
        
    @objc internal func didTapClearScene() {
        playWavSound(soundName: SoundNames.click.rawValue)
        augmentedRealityView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
    }
    
    @objc func updateLabel() {
        identifier = mlPrediction        
    }
}
