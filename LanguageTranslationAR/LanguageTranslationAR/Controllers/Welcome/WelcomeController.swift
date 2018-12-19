//
//  WelcomeController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/14/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 50
        return stackView
    }()
    
    let button: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        button.setTitle("WELCOME_BUTTON_TEXT".localized(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func didSelectContinueButton() {
        let cameraPermissionVC = PermissionsController()
        navigationController?.pushViewController(cameraPermissionVC, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}
