//
//  LearningController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 26/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class LearningController: UIViewController {
    
    let titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "ONBOARDING_CHOOSE_LANG_TITLE".localized
        return label
    }()
    
    let descriptionLabel: DescriptionLabel = {
        let label = DescriptionLabel()
        label.text = "ONBOARDING_CHOOSE_LANG_DESCRIPTION".localized
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.fillToSuperview(constant: 40)
        
        let button = CustomButton()
        button.setTitle("ONBOARDING_CHOOSE_BUTTON".localized, for: .normal)
        button.addTarget(self, action: #selector(presentLanguageSelection), for: .touchUpInside)
                
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.spacing = 10
        
        stackView.addArrangedSubview(labelStackView)
        
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        buttonsStackView.addArrangedSubview(button)
//        buttonsStackView.addArrangedSubview(skipButton)
        stackView.addArrangedSubview(buttonsStackView)
    }
        
    @objc private func presentLanguageSelection() {
        let vc = LanguagesController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
