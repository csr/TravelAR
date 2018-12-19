//
//  CameraPermissionController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVFoundation

class PermissionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .black
    
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.fillToSuperview(constant: 40)
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        let attributedString = NSMutableAttributedString(string: "CAMERA_PERMISSIONS_TITLE".localized())
        attributedString.setColor(color: UIColor.orange, forText: "TranslateAR")
        titleLabel.attributedText = attributedString
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33)
        titleLabel.numberOfLines = 0
        
        let button = CustomButton()
        button.addTarget(self, action: #selector(requestCameraAccess), for: .touchUpInside)
        button.setTitle("CAMERA_PERMISSIONS_BUTTON_TITLE".localized(), for: .normal)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
    }
    
    internal func didAuthorizeCamera() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func requestCameraAccess() {
        print("requesting camera access...")
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            print("was access granted?", granted)
            DispatchQueue.main.async {
                self.cameraSelected()
            }
        }
    }
    
    func cameraSelected() {
        // First we check if the device has a camera (otherwise will crash in Simulator - also, some iPod touch models do not have a camera).
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authStatus {
            case .authorized:
                print("authorized! dismissing...")
                self.dismiss(animated: true, completion: nil)
            case .denied:
                print("denied!!")
                alertPromptToAllowCameraAccessViaSettings()
            case .notDetermined:
                print("not determined")
            //                permissionPrimeCameraAccess()
            default:
                print("default")
                //                permissionPrimeCameraAccess()
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Device has no camera", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                //                Analytics.track(event: .permissionsPrimeCameraNoCamera)
            })
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
