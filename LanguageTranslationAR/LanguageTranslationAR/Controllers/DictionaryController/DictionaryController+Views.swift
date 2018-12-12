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
    
    // Add a Clear navigation right item
    
	internal func setupViews() {
        view.backgroundColor = .black
		setupSceneView()
        setupAddButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "NAV_BAR_CLEAR".localized(), style: .plain, target: self, action: #selector(didTapClearScene))
    }
    
    internal func setupAddButton() {
        view.addSubview(addButton)        
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
	private func setupSceneView() {
		view.addSubview(augmentedRealityView)
        let constraints = [augmentedRealityView.topAnchor.constraint(equalTo: view.topAnchor),
                                              augmentedRealityView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                              augmentedRealityView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                              augmentedRealityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
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
            
            if self.view.traitCollection.horizontalSizeClass == .regular {
                dictionaryViewBottomAnchor.constant = -30
            } else {
                dictionaryViewBottomAnchor.constant = -115
            }
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
