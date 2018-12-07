//
//  SettingsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class SettingsController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    internal func setupNavigationBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
