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
        stackView.spacing = 50
        
        let button = getBottomButton()
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(getTopLabel())
        stackView.addArrangedSubview(getMiddleStackView())
        stackView.addArrangedSubview(button)
    }
    
    private func getTopLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        let attributedString = NSMutableAttributedString(string: "WELCOME_TITLE".localized())
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
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }
    
    private func getMiddleStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        let firstItem = getItemStackView(title: "WELCOME_FIRST_ITEM_TITLE".localized(), description: "WELCOME_FIRST_ITEM_DESCRIPTION".localized(), imageName: "welcome-first")
        let secondItem = getItemStackView(title: "WELCOME_SECOND_ITEM_TITLE".localized(), description: "WELCOME_SECOND_ITEM_DESCRIPTION".localized(), imageName: "welcome-second")
        let thirdItem = getItemStackView(title: "WELCOME_THIRD_ITEM_TITLE".localized(), description: "WELCOME_THIRD_ITEM_DESCRIPTION".localized(), imageName: "welcome-third")
        
        stackView.addArrangedSubview(firstItem)
        stackView.addArrangedSubview(secondItem)
        stackView.addArrangedSubview(thirdItem)
        stackView.distribution = .equalCentering
        return stackView
    }
    
    private func getItemStackView(title: String, description: String, imageName: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.alignment = .center
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .orange
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = description
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelsStackView)
        return stackView
    }
    
    @objc func didSelectContinueButton() {        
        //dismiss(animated: true, completion: nil)
        requestCameraAccess()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}
