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
        setupCoreML()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true).fire()
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
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
}
