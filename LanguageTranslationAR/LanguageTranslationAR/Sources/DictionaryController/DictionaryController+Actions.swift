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
        lookAroundLabel.alpha = 1
        lookAroundLabel.blink()
        setupTimers()
        shouldShowTopView = true
        topView.alpha = 1
        setupAR()
    }
    
    @objc internal func didTapClearScene() {
        SystemSoundID.playFileNamed(fileName: "button-click-garageband", withExtenstion: "wav")
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    @objc internal func didTapOKTapToAdd() {
        popUpView.shouldShowImageWalkthrough = false
    }
    
    @objc func handleTapOnBookmarks() {
        SystemSoundID.playFileNamed(fileName: "button-click-garageband", withExtenstion: "wav")
        
        if let constant = hintViewCenterXAnchor?.constant {
            hintViewCenterXAnchor?.constant = constant - 60
        }
        view.layoutIfNeeded()
        let nav = UINavigationController(rootViewController: bookmarksPopoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        popover?.permittedArrowDirections = .up
        navigationController?.popoverPresentationController?.backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
        
        if bookmarksPopoverContent.list.isEmpty {
            bookmarksPopoverContent.preferredContentSize = CGSize(width: 400, height: 150)
        } else {
            bookmarksPopoverContent.preferredContentSize = CGSize(width: 400, height: 370)
        }
        
        popover?.sourceView = self.view
        popover?.sourceRect = topView.bookmarksButton.frame
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleTapOnLanguageSelection() {
        SystemSoundID.playFileNamed(fileName: "button-click-garageband", withExtenstion: "wav")
        hintHandView.isHidden = true
        
        let nav = UINavigationController(rootViewController: translationPopoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        popover?.permittedArrowDirections = .up
        navigationController?.popoverPresentationController?.backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
        translationPopoverContent.preferredContentSize = CGSize(width: 350, height: 300)
        popover?.sourceView = self.view
        popover?.sourceRect = topView.translationButton.frame
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func updateLabel() {
        guard let text = topView.identifierLabel.text else {
            return
        }
        
        if (text == mlPrediction) {
            return
        }
        
        if (text == "Nothing found..." || text == "Scanning...") && mlPrediction == nil {
            imageViewWalkthrough.layer.removeAllAnimations()
            return
        }
        
        topView.identifierLabel.alpha = mlPrediction != nil ? 1 : 0.5
        topView.identifierLabel.text = mlPrediction != nil ? mlPrediction : "Nothing found..."
        animateImageWalkthrough(shouldBeHidden: mlPrediction == nil)
        
        if mlPrediction != nil {
            SystemSoundID.playFileNamed(fileName: "pop_drip", withExtenstion: "wav")
            imageViewWalkthrough.boingAnimation()
        } else {
            SystemSoundID.playFileNamed(fileName: "pop_drip-reverse", withExtenstion: "wav")
        }
        
        topView.identifierLabel.pushTransition(0.3)
    }
    
    @objc func detectPlanes() {
        if detectWorldCoordinates() != nil {
            planesDetectedState()
        }
    }
    
    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        print("handletap")
        if popUpView.frame.width > 0 {
            return
        }
        
        if let coords = detectWorldCoordinates() {
            print("didtapsceneview")
            didTapSceneView(coords: coords)
        } else {
            print("shaking?")
            imageViewWalkthrough.shake()
            topView.identifierLabel.shake()
        }
    }
}
