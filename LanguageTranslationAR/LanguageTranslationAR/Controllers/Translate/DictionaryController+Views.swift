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
        setupClearButton()
    }
    
    func setupClearButton() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "NAV_BAR_CLEAR".localized()
        blurEffectView.contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 11).isActive = true
        label.rightAnchor.constraint(equalTo: blurEffectView.rightAnchor, constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: blurEffectView.leftAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -11).isActive = true
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 15
        
        blurEffectView.topAnchor.constraint(equalTo: view.topAnchor, constant: 7).isActive = true
        blurEffectView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -7).isActive = true
        
        blurEffectView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapClearScene))
        blurEffectView.addGestureRecognizer(tapRecognizer)
    }
    
    internal func setupAddButton() {
        view.addSubview(addButton)        
        addButton.widthAnchor.constraint(equalToConstant: 73).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 73).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -39).isActive = true
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

class InstructionView: UIVisualEffectView {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .dark)
        super.init(effect: blurEffect)
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
