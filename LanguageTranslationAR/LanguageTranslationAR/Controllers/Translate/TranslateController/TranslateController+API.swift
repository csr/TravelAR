//
//  DictionaryController+API.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension TranslateController {
    func getTranslation(text: String, completion: @escaping (Translation?) -> Void) {
        print("Sending translation request...")
        let userLanguage = LanguagePreferences.getCurrent()
        
        translateOriginalText(text: text) { (string) in
            
            let sourceLanguage = LanguagePreferences.getLocaleLanguageCode()
            let targetLanguage = userLanguage.code
            
            GoogleTranslateAPI.shared.getTranslation(for: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage) { result in
                switch result {
                case .success(var translation):
                    translation.originalText = string
                    completion(translation)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func translateOriginalText(text: String, completion: @escaping (String?) -> Void) {
        let langLocaleCode = LanguagePreferences.getLocaleLanguageCode()
        
        // The object recognition model returns an English label for the objects
        // This means there's an additional translation step if our system languge isn't English
        
        // If our system language is English, no need to translate, return text
        if langLocaleCode.uppercased() == "EN" {
            completion(text)
        // Otherwise translate the English object label to our system language
        } else {
            GoogleTranslateAPI.shared.getTranslation(for: text, sourceLanguage: "EN", targetLanguage: langLocaleCode) { result in
                switch result {
                case .success(let translation):
                    completion(translation.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
