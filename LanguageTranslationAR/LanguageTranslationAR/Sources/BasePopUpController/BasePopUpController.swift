//
//  BasePopUpController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 02/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVKit

class BasePopUpController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        view.backgroundColor = .white        
    }
    
    @objc func handleTapOnDone() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 20)
        navigationController?.navigationBar.barTintColor = .deepBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: font!]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleTapOnDone))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleTapOnDone))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
