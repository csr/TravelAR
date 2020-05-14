//
//  SettingsController+MFMailComposeViewControllerDelegate.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 5/14/20.
//  Copyright © 2020 Cesare de Cal. All rights reserved.
//

import MessageUI

extension SettingsController: MFMailComposeViewControllerDelegate {
    func composeSupportEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.setToRecipients(["help@cesare.io"])
        composeVC.mailComposeDelegate = self
        composeVC.setSubject("SUPPORT_MESSAGE_TITLE".localized)
        present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
