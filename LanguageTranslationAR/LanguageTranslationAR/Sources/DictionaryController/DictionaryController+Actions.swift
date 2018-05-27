//
//  DictionaryController+Actions.swift
//  MirrorProject
//
//  Created by Cesare de Cal on 31/03/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVKit

@available(iOS 11.0, *)
extension DictionaryController {
    @objc func detectingPlanesState() {
        sceneView.alpha = 1
        planesDetectedView.alpha = 1
        shouldShowTopView = true
        topView.alpha = 1
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
