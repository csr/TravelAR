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
        let title = NSLocalizedString("Translation language", comment: "Translation language")
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let customView = UIView()
        alertController.view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 45).isActive = true
        customView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -10).isActive = true
        customView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 10).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        customView.addSubview(pickerView)
        pickerView.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: customView.rightAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: customView.leftAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: customView.bottomAnchor).isActive = true
        
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.heightAnchor.constraint(equalToConstant: 430).isActive = true
        let selectionTitle = NSLocalizedString("Select", comment: "Select")
        let selectAction = UIAlertAction(title: selectionTitle, style: .default) { (action) in
            self.didSelectLanguage()
        }
        
        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            //popoverController.sourceRect = CGRect(x: view.frame.width, y: topView.frame.height, width: 0, height: 0)
            //print("frame of topView bookmarks button:", topView.bookmarksStackView.frame)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    internal func didSelectLanguage() {
        let index = pickerView.selectedRow(inComponent: 0)
        let language = languages[index]
        selectedLanguage = language
    }    
}
