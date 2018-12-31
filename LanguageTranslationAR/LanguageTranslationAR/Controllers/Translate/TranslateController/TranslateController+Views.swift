//
//  DictionaryController+Views.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension TranslateController: AddButtonProtocol {
    
	internal func setupViews() {
        view.backgroundColor = .black
        
        if Testing.isTesting {
            view.addSubview(testImageView)
            testImageView.fillToSuperview(includeNotch: true)            
        } else {
            setupSceneView()
            setupCustomView()
        }
        setupAddButton()
        setupClearButton()
        setupFeedbackView()
        setupScanningView()
        changeScanningState(planesDetected: false)
    }
        
    private func setupFeedbackView() {
        view.addSubview(feedbackView)
        feedbackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 66).isActive = true
        feedbackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupScanningView() {
        view.addSubview(scanningView)
        scanningView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scanningView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func changeScanningState(planesDetected: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.addButton.isHidden = !planesDetected
            self.feedbackView.isHidden = !planesDetected
            self.clearButtonView.isHidden = !planesDetected
            self.tipView.isHidden = !planesDetected
            self.scanningView.isHidden = planesDetected
        }
        
        if planesDetected {
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true).fire()
        }
    }
    
    private func setupCustomView() {
        view.addSubview(customView)
        customView.topAnchor.constraint(equalTo: view.topAnchor, constant: -300).isActive = true
        
        if Testing.isTesting {
            self.feedbackView.textLabel.text = "TEST_LABEL".localized
        }
    }

    func setupClearButton() {
        view.addSubview(clearButtonView)
        clearButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7).isActive = true
        clearButtonView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -7).isActive = true
    }
    
    internal func setupAddButton() {
        view.addSubview(addButton)        
        addButton.widthAnchor.constraint(equalToConstant: 73).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 73).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -39).isActive = true
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(showToolTip), userInfo: nil, repeats: false)
    }
    
	private func setupSceneView() {
		view.addSubview(sceneView)
        sceneView.fillToSuperview(includeNotch: true)
        sceneView.fillToSuperview()
	}
}
