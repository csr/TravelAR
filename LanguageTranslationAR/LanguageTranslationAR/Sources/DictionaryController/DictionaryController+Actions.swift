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
    internal func animateImageWalkthrough(shouldBeHidden: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.imageViewWalkthrough.alpha = shouldBeHidden ? 0.2 : 1
        }
    }
    
    func didTapSceneView(coords: SCNVector3) {
        guard let latestPrediction = mlPrediction else {
            imageViewWalkthrough.shake()
            topView.identifierLabel.shake()
            return
        }
        
        if !latestPrediction.isEmpty {
            getTranslation(text: latestPrediction) { (translation) in
                DispatchQueue.main.async {
                    if let translation = translation {
                        self.addNode(title: latestPrediction, subtitle: translation.translatedText, coords: coords)
                        self.handleIncomingTranslation(translation: translation)
                    }
                }
            }
        } else {
            imageViewWalkthrough.shake()
            return
        }
    }
    
    func handleIncomingTranslation(translation: Translation) {
        self.animateDictionaryView(item: translation)
        TextToSpeech.speak(item: translation)
        
        if !items.contains(translation) {
            items.append(translation)
            self.topView.bookmarksButton.boingAnimation()
            self.clearButton.isHidden = false
        }
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
        topView.showRightIcons()
        popUpView.shouldShowImageWalkthrough = false
        UIView.animate(withDuration: 0.5) {
            self.imageViewWalkthrough.alpha = 1
            self.cameraOverlayView.alpha = 1
        }
    }
    
    @objc func handleTapOnBookmarks() {
        playWavSound(soundName: SoundNames.click.rawValue)
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
        
        popover?.sourceView = self.view
        popover?.sourceRect = topView.bookmarksButton.frame
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleTapOnLanguageSelection() {
        playWavSound(soundName: SoundNames.click.rawValue)
        loadLanguages()
        showPickerController()        
    }
    
    @objc func updateLabel() {
        identifier = mlPrediction        
    }
        
    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        if let coords = detectWorldCoordinates() {
            didTapSceneView(coords: coords)
        } else {
            imageViewWalkthrough.shake()
            topView.identifierLabel.shake()
        }
    }
}
