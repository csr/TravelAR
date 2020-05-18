//
//  WelcomeController.swift
//  LanguageTranslationAR
//

import UIKit

class WelcomeController: UIViewController {
        
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let titleLabel: TitleLabel = {
        let titleLabel = TitleLabel()
        let attributedString = NSMutableAttributedString(string: "WELCOME_TITLE".localized)
        attributedString.setColor(color: .primary, forText: "TranslateAR")
        titleLabel.attributedText = attributedString
        return titleLabel
    }()
    
    let continueOnboardingButton: CustomButton = {
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
        view.backgroundColor = UIColor.cell
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupContentStackView() {
        view.addSubview(stackView)
        stackView.fillToSuperview(constant: 40)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(getMiddleStackView())
        stackView.addArrangedSubview(continueOnboardingButton)
    }
    
    private func getMiddleStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 45
        let firstItem = getItemStackView(title: "WELCOME_FIRST_ITEM_TITLE".localized, description: "WELCOME_FIRST_ITEM_DESCRIPTION".localized, image: UIImage.welcomeFirst)
        let secondItem = getItemStackView(title: "WELCOME_SECOND_ITEM_TITLE".localized, description: "WELCOME_SECOND_ITEM_DESCRIPTION".localized, image: UIImage.welcomeSecond)
        let thirdItem = getItemStackView(title: "WELCOME_THIRD_ITEM_TITLE".localized, description: "WELCOME_THIRD_ITEM_DESCRIPTION".localized, image: UIImage.welcomeThird)
        
        stackView.addArrangedSubview(firstItem)
        stackView.addArrangedSubview(secondItem)
        stackView.addArrangedSubview(thirdItem)
        stackView.distribution = .equalCentering
        return stackView
    }
    
    private func getItemStackView(title: String, description: String, image: UIImage?) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.alignment = .center
                
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
                
        labelsStackView.addArrangedSubview(getTitleLabel(text: title))
        labelsStackView.addArrangedSubview(getDescriptionLabel(text: description))
        
        stackView.addArrangedSubview(getImageView(image: image))
        stackView.addArrangedSubview(labelsStackView)
        return stackView
    }
    
    private func getImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .primary
        return imageView
    }
    
    private func getDescriptionLabel(text: String) -> UILabel {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = text
        return descriptionLabel
    }
    
    private func getTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
}
