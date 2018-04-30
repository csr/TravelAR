//
//  DictionaryController+Views.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
extension DictionaryController {
	internal func setupViews() {
        view.backgroundColor = .black
        topView.alpha = 0
		setupSceneView()
		setupCameraOverlayView()
        setupTopViewActions()
        setupInstructionsLabel()
        setupPopView()
        setupClearButton()
	}
    
    internal func setupClearButton() {
        view.addSubview(clearButton)
        clearButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        clearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18.5).isActive = true
        clearButton.addTarget(self, action: #selector(didTapClearScene), for: .touchUpInside)
    }
    
    internal func setupImageViewHint() {
        view.addSubview(hintHandView)
        hintViewCenterXAnchor = hintHandView.centerXAnchor.constraint(equalTo: topView.bookmarksButton.centerXAnchor, constant: 4)
        hintViewCenterXAnchor?.isActive = true
        
        hintHandView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        hintHandView.widthAnchor.constraint(equalToConstant: 57).isActive = true
        hintHandView.heightAnchor.constraint(equalToConstant: 57).isActive = true
        view.bringSubview(toFront: hintHandView)
        hintHandView.layer.zPosition = topView.layer.zPosition + 1
        hintHandView.alpha = 1
        
        let origin = hintHandView.center
        let bounce = CABasicAnimation(keyPath: "position.y")
        bounce.duration = 0.5
        bounce.fromValue = origin.y+95
        bounce.toValue = origin.y+80
        bounce.repeatCount = .greatestFiniteMagnitude
        bounce.autoreverses = true
        hintHandView.layer.add(bounce, forKey: "position")
    }
    
    private func setupPopView() {
        view.addSubview(popUpView)
        popUpCenterYAnchor = popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        popUpCenterYAnchor?.isActive = true
        popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpView.layer.zPosition = 500
    }
 
    private func setupInstructionsLabel() {
        view.addSubview(lookAroundLabel)
        lookAroundLabel.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor).isActive = true
        lookAroundLabel.centerYAnchor.constraint(equalTo: sceneView.centerYAnchor).isActive = true
        lookAroundLabel.widthAnchor.constraint(equalTo: sceneView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupTopViewActions() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLanguageSelection))
        topView.languageLabel.isUserInteractionEnabled = true
        topView.languageLabel.addGestureRecognizer(tapRecognizer)
        topView.translationButton.addTarget(self, action: #selector(handleTapOnLanguageSelection), for: .touchUpInside)
        topView.bookmarksButton.addTarget(self, action: #selector(handleTapOnBookmarks), for: .touchUpInside)
    }
	
	private func setupSceneView() {
		view.addSubview(sceneView)
		sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		sceneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		sceneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		view.bringSubview(toFront: topView)
	}
	
	private func setupCameraOverlayView() {
		view.addSubview(cameraOverlayView)
		cameraOverlayView.centerYAnchor.constraint(equalTo: sceneView.centerYAnchor).isActive = true
		cameraOverlayView.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor).isActive = true
		
        let viewHeight: CGFloat = 330
		cameraOverlayView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
		cameraOverlayView.widthAnchor.constraint(equalToConstant: viewHeight).isActive = true
		cameraOverlayView.layer.cornerRadius = viewHeight / 2
		
		view.addSubview(centerButton)
		centerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		centerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		view.addSubview(imageViewWalkthrough)
		imageViewWalkthrough.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		imageViewWalkthrough.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		imageViewWalkthrough.heightAnchor.constraint(equalToConstant: 89).isActive = true
		imageViewWalkthrough.widthAnchor.constraint(equalToConstant: 52).isActive = true
	}
	
	internal func setupTapGestureRecognizer() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognize:)))
		view.addGestureRecognizer(tapGesture)
	}
	
    internal func animateDictionaryView(item: Item) {
        print("animating view...")
        let dictionaryView = DictionaryView()
        dictionaryView.layer.zPosition = 10
        view.addSubview(dictionaryView)
        let dictionaryViewBottomAnchor = dictionaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        dictionaryViewBottomAnchor.isActive = true
        dictionaryViewBottomAnchor.constant = 200
        self.view.layoutIfNeeded()
        dictionaryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dictionaryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dictionaryView.alpha = 0
        
		view.layoutIfNeeded()
        
        dictionaryView.transform = CGAffineTransform(scaleX: 0.3, y: 2)

        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
			self.view.layoutIfNeeded()
			dictionaryViewBottomAnchor.constant = -80
            dictionaryView.transform = .identity
			self.view.layoutIfNeeded()
            dictionaryView.alpha = 1
		}) { (bool) in
			UIView.animate(withDuration: 2, delay: 3.5, usingSpringWithDamping: 10, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
				self.view.layoutIfNeeded()
				dictionaryViewBottomAnchor.constant = 500
				self.view.layoutIfNeeded()
                dictionaryView.alpha = 0
			}) { (bool) in
			}
		}
        
        dictionaryView.item = item
	}
}
