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
                    }
                }
            }
        }
    }
    
    func handleIncomingTranslation(translation: Translation) {
        self.animateDictionaryView(item: translation)
        TextToSpeech.speak(item: translation)        
    }
    
    func didTapButton(selector: Selector) {
        playWavSound(soundName: SoundNames.popReverse.rawValue)
        performSelector(onMainThread: selector, with: nil, waitUntilDone: true)
    }
    
    @objc internal func didTapClearScene() {
        playWavSound(soundName: SoundNames.click.rawValue)
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    @objc internal func didTapOKTapToAdd() {
        popUpView.shouldShowImageWalkthrough = false
        UIView.animate(withDuration: 0.5) {
            self.cameraOverlayView.alpha = 1
        }
    }
    
    @objc func handleTapOnBookmarks() {
        let vc = ListController()
        vc.list = items
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        popover?.permittedArrowDirections = .up
        navigationController?.popoverPresentationController?.backgroundColor = .deepBlue
        
        if items.isEmpty {
            vc.preferredContentSize = CGSize(width: 400, height: 150)
        } else {
            vc.preferredContentSize = CGSize(width: 400, height: 370)
        }
        
        if let items = navigationItem.rightBarButtonItems, let first = items.first {
            popover?.barButtonItem = first
        }
        
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleTapOnLanguageSelection() {
        loadLanguages()
        showPickerController()        
    }
    
    @objc func updateLabel() {
        identifier = mlPrediction        
    }

    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        if let coords = detectWorldCoordinates() {
            didTapSceneView(coords: coords)
        }
    }
}
