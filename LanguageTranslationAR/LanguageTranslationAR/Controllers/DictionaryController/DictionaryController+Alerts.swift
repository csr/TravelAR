//
//  DictionaryController+Alerts.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension DictionaryController {
    internal func presentWelcomeAlert() {
        let title = NSLocalizedString("Turn on camera", comment: "Turn on camera")
        let subtitle = NSLocalizedString("Ask camera permission", comment: "Ask camera permission")
        let buttonActionTitle = NSLocalizedString("OK", comment: "OK")
        popUpView.present(title: title, subtitle: subtitle, buttonAction: buttonActionTitle, completionHandler: #selector(requestCameraAccess))
    }
        
    internal func presentDeniedCameraPermissionsAlert() {
        let title = NSLocalizedString("Camera permissions", comment: "Camera permissions")
        let buttonActionTitle = NSLocalizedString("Enable camera", comment: "Go to settings")
        popUpView.present(title: "Ooops!", subtitle: title, buttonAction: buttonActionTitle, imageName: "welcome", completionHandler: #selector(openCameraSettings))
    }
    
    internal func presentAppInstructionAlert() {
        let title = NSLocalizedString("How to use", comment: "How to use")
        let format = NSLocalizedString("Point device", comment: "Point device at object")
        let subtitle = String.localizedStringWithFormat(format, getDeviceName())
        let buttonTitle = NSLocalizedString("OK", comment: "OK, let's try!")
        popUpView.present(title: title, subtitle: subtitle, buttonAction: buttonTitle, imageName: "phone-sketch", completionHandler: #selector(didTapOKTapToAdd))
        popUpView.shouldShowImageWalkthrough = true
    }
}
