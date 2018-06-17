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
        setupPopView()
        setupNavigationBar()
        setupSuggestionView()
        setupAddButton()
	}
    
    internal func setupAddButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    internal func setupSuggestionView() {
        view.addSubview(suggestionView)
        suggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        suggestionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        suggestionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    internal func setupNavigationBar() {
        title = NSLocalizedString("Capture", comment: "Capture")
        let clearString = NSLocalizedString("Clear", comment: "Clear")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: clearString, style: .plain, target: self, action: #selector(didTapClearScene))
        let historyItem = UIBarButtonItem(image: UIImage(named: "history"), style: .plain, target: self, action: #selector(handleTapOnBookmarks))
        let translateItem = UIBarButtonItem(image: UIImage(named: "translate"), style: .plain, target: self, action: #selector(handleTapOnLanguageSelection))
        let buttonItems = [historyItem, translateItem]
        navigationItem.rightBarButtonItems = buttonItems
    }
    
    private func setupPopView() {
        view.addSubview(popUpView)
        popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpView.layer.zPosition = 500
    }
    
	private func setupSceneView() {
		view.addSubview(augmentedRealityView)
		augmentedRealityView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		augmentedRealityView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		augmentedRealityView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		augmentedRealityView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseIn, animations: {
			self.view.layoutIfNeeded()
			dictionaryViewBottomAnchor.constant = -80
            dictionaryView.transform = .identity
			self.view.layoutIfNeeded()
            dictionaryView.alpha = 1
		}) { (bool) in
			UIView.animate(withDuration: 2, delay: 3.5, usingSpringWithDamping: 10, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
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
