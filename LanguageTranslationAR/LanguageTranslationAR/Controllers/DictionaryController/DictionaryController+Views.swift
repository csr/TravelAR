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
//        setupNavigationBar()
        setupSuggestionView()
        setupAddButton()
        setupHistoryView()
    }
    
    internal func setupHistoryView() {
        
    }
            
    internal func setupAddButton() {
        let stackView = UIStackView(arrangedSubviews: [addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
        
        view.addSubview(stackView)
        
        stackView.alignment = .center
        stackView.spacing = 25
        
        compactConstraints.append(contentsOf: [addButton.widthAnchor.constraint(equalToConstant: 80),
                                               addButton.heightAnchor.constraint(equalToConstant: 80),
                                               stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                               stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)])
        
        regularConstraints.append(contentsOf: [addButton.widthAnchor.constraint(equalToConstant: 100),
                                               addButton.heightAnchor.constraint(equalToConstant: 100),
                                               stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                               stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)])

        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    internal func setupSuggestionView() {
        view.addSubview(suggestionView)
        sharedConstraints.append(contentsOf: [suggestionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                              suggestionView.heightAnchor.constraint(equalToConstant: 55)])
        regularConstraints.append(contentsOf: [suggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)])
        compactConstraints.append(contentsOf: [suggestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)])
    }
    
//    internal func setupNavigationBar() {
//        title = NSLocalizedString("Capture", comment: "Capture")
//        let clearString = NSLocalizedString("Clear", comment: "Clear")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: clearString, style: .plain, target: self, action: #selector(didTapClearScene))
//        let historyItem = UIBarButtonItem(image: UIImage(named: "history"), style: .plain, target: self, action: #selector(handleTapOnBookmarks))
//        let translateItem = UIBarButtonItem(image: UIImage(named: "translate"), style: .plain, target: self, action: #selector(handleTapOnLanguageSelection))
//        let buttonItems = [historyItem, translateItem]
//        navigationItem.rightBarButtonItems = buttonItems
//    }
    
    private func setupPopView() {
        view.addSubview(popUpView)
        sharedConstraints.append(contentsOf: [popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                              popUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        popUpView.layer.zPosition = 500
    }
    
	private func setupSceneView() {
		view.addSubview(augmentedRealityView)
        sharedConstraints.append(contentsOf: [augmentedRealityView.topAnchor.constraint(equalTo: view.topAnchor),
                                              augmentedRealityView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                              augmentedRealityView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                              augmentedRealityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
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
            
            if self.view.traitCollection.horizontalSizeClass == .regular {
                dictionaryViewBottomAnchor.constant = -30
            } else {
                dictionaryViewBottomAnchor.constant = -115
            }
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
