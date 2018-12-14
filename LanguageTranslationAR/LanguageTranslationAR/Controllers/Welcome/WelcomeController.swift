//
//  WelcomeController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/14/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        view.backgroundColor = .black
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -40).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        stackView.spacing = 40
        
        let testView = UIView()
        testView.backgroundColor = .red
        
        stackView.addArrangedSubview(getTopLabel())
        stackView.addArrangedSubview(testView)
        stackView.addArrangedSubview(getBottomButton())
    }
    
    private func getTopLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        let attributedString = NSMutableAttributedString(string: "Welcome to TranslateAR")
        attributedString.setColor(color: UIColor.orange, forText: "TranslateAR")
        titleLabel.attributedText = attributedString
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33)
        titleLabel.numberOfLines = 0
        return titleLabel
    }
    
    private func getBottomButton() -> UIButton {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WELCOME_BUTTON_TEXT".localized(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }
}

class CustomButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.orange.withAlphaComponent(0.5) : .orange
        }
    }
}
