//
//  CameraPermissionController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVFoundation

class PermissionsController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let attributedString = NSMutableAttributedString(string: "CAMERA_PERMISSIONS_TITLE".localized())
        attributedString.setColor(color: UIColor.orange, forText: "TranslateAR")
        label.attributedText = attributedString
        label.font = UIFont.boldSystemFont(ofSize: 33)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "CAMERA_PERMISSIONS_DESCRIPTION".localized()
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "camera")
        return imageView
    }()
    
    private let button: CustomButton = {
        let button = CustomButton()
        button.addTarget(self, action: #selector(didTapAllowButton), for: .touchUpInside)
        button.setTitle("CAMERA_PERMISSIONS_BUTTON_TITLE".localized(), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(stackView)
        stackView.fillToSuperview(constant: 40)
        
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.spacing = 10
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(button)
    }
    
    internal func didAuthorizeCamera() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAllowButton() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                self.cameraSelected()
            }
        }
    }
    
    func cameraSelected() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authStatus {
            case .authorized:
                self.dismiss(animated: true, completion: nil)
            case .denied:
                alertPromptToAllowCameraAccessViaSettings()
            default:
                return
            }
        } else {
            let alertController = UIAlertController(title: "NO_CAMERA_BUTTON_ALERT_TITLE".localized(), message: "NO_CAMERA_BUTTON_ALERT_MESSAGE".localized(), preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "NO_CAMERA_BUTTON_OK".localized(), style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func alertPromptToAllowCameraAccessViaSettings() {
        let alert = UIAlertController(title: "PERMISSION_TITLE".localized(), message: "PERMISSION_DESCRIPTION".localized(), preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "PERMISSION_ACTION_SETTINGS".localized(), style: .cancel) { alert in
            if let appSettingsURL = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettingsURL as URL, options: [:], completionHandler: nil)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}