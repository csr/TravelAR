//
//  DictionaryController+LanguagePicker.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension DictionaryController {
    internal func showPickerController() {
        let vc = LanguagesTableViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        vc.popoverPresentationController?.permittedArrowDirections = .up
        vc.preferredContentSize = CGSize(width: 400, height: 400)
        
        if let popoverController = nav.popoverPresentationController, let items = navigationItem.rightBarButtonItems {
            let second = items[1]
            popoverController.barButtonItem = second
        }
        
        self.present(nav, animated: true, completion: nil)
    }
    
    internal func didSelectLanguage() {
        let index = pickerView.selectedRow(inComponent: 0)
        let language = languages[index]
        selectedLanguage = language
    }    
}
