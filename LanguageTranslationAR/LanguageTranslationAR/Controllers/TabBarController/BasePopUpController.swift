//
//  BasePopUpController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 02/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        view.backgroundColor = .black
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
