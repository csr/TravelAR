//
//  DictionaryController+Camera.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 27/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension DictionaryController {
    func didAuthorizeCamera() {
        setupAR()
        presentAppInstructionAlert()
        setupCoreML()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true).fire()
    }
    
    func cameraNotYetAuthorized() {
    }
    
    func cameraPermissionDenied() {
        presentDeniedCameraPermissionsAlert()
    }
    
    @objc func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            DispatchQueue.main.async {
                if granted {
                    self.didAuthorizeCamera()
                } else {
                    self.cameraPermissionDenied()
                }
            }
        }
    }
    
    @objc internal func checkCameraPermissions() {
        print("check camera permissions...")
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .denied:
            cameraPermissionDenied()
        case .authorized:
            didAuthorizeCamera()
        case .restricted:
            break
        case .notDetermined:
            presentWelcomeAlert()
        }
    }
    
    @objc func openCameraSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}