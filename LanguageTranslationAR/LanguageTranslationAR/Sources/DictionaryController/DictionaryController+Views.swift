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
		setupSceneView()
		setupCameraOverlayView()
        setupPopView()
        setupNavigationBar()
	}
    
    internal func setupNavigationBar() {
        title = "Capture"
        let clearString = NSLocalizedString("Clear", comment: "Clear")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: clearString, style: .plain, target: self, action: #selector(didTapClearScene))
        let historyButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(handleTapOnBookmarks))
        let buttonItems = [historyButton]
        navigationItem.rightBarButtonItems = buttonItems
    }
    
    private func setupPopView() {
        view.addSubview(popUpView)
        popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpView.layer.zPosition = 500
    }
    
	private func setupSceneView() {
		view.addSubview(sceneView)
		sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		sceneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		sceneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
	}
	
	internal func setupTapGestureRecognizer() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognize:)))
		view.addGestureRecognizer(tapGesture)
	}
	
    internal func animateDictionaryView(item: Translation) {
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
        
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: UIView.AnimationOptions.curveEaseIn, animations: {
			self.view.layoutIfNeeded()
			dictionaryViewBottomAnchor.constant = -80
            dictionaryView.transform = .identity
			self.view.layoutIfNeeded()
            dictionaryView.alpha = 1
		}) { (bool) in
			UIView.animate(withDuration: 2, delay: 3.5, usingSpringWithDamping: 10, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
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
