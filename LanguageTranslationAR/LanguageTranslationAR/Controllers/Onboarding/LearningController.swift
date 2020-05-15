//
//  LearningController.swift
//  LanguageTranslationAR
//

import UIKit

class LearningController: UIViewController {
    
    private let titleLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = "ONBOARDING_CHOOSE_LANG_TITLE".localized
        return label
    }()

    private let descriptionLabel: DescriptionLabel = {
        let label = DescriptionLabel()
        label.text = "ONBOARDING_CHOOSE_LANG_DESCRIPTION".localized
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.welcomeLanguage
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cell
        setupStackView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
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
        stackView.addArrangedSubview(imageView)

        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        buttonsStackView.addArrangedSubview(button)
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
