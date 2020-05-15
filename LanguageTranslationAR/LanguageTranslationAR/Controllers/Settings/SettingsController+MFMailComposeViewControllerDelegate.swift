//
//  SettingsController+MFMailComposeViewControllerDelegate.swift
//  LanguageTranslationAR
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
