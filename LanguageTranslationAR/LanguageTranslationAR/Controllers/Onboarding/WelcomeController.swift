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
    
    let titleLabel: TitleLabel = {
        let titleLabel = TitleLabel()
        let attributedString = NSMutableAttributedString(string: "WELCOME_TITLE".localized)
        attributedString.setColor(color: UIColor.orange, forText: "TranslateAR")
        titleLabel.attributedText = attributedString
        return titleLabel
    }()
    
    let button: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(didSelectContinueButton), for: .touchUpInside)
        button.setTitle("WELCOME_BUTTON_TEXT".localized, for: .normal)
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
    
    internal func setupView() {
        setupContentStackView()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupContentStackView() {
        view.addSubview(stackView)
        stackView.fillToSuperview(constant: 40)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(getMiddleStackView())
        stackView.addArrangedSubview(button)
    }
    
    private func getMiddleStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        let firstItem = getItemStackView(title: "WELCOME_FIRST_ITEM_TITLE".localized, description: "WELCOME_FIRST_ITEM_DESCRIPTION".localized, imageName: "welcome-first")
        let secondItem = getItemStackView(title: "WELCOME_SECOND_ITEM_TITLE".localized, description: "WELCOME_SECOND_ITEM_DESCRIPTION".localized, imageName: "welcome-second")
        let thirdItem = getItemStackView(title: "WELCOME_THIRD_ITEM_TITLE".localized, description: "WELCOME_THIRD_ITEM_DESCRIPTION".localized, imageName: "welcome-third")
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}
