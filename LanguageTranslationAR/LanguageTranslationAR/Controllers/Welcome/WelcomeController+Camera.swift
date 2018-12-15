//
//  WelcomeController+Camera.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/15/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVFoundation

extension WelcomeController {
    func cameraPermissionDenied() {
        //        presentDeniedCameraPermissionsAlert()
    }
    
    internal func didAuthorizeCamera() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func requestCameraAccess() {
        print("requesting camera access...")
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            print("was access granted?", granted)
            DispatchQueue.main.async {
                if granted {
                    self.didAuthorizeCamera()
                } else {
                    self.cameraPermissionDenied()
                }
            }
        }
    }    
}
