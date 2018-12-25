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
        print("Sent translation request...")
        let userLanguage = LanguagePreferences.getCurrent()
        
        translateOriginalText(text: text) { (string) in
            if let string = string {
                GoogleTranslateAPI.getTranslation(for: text, sourceLanguage: LanguagePreferences.getLocaleLanguageCode(), targetLanguage: userLanguage.languageCode) { (translation) in
                    var translationCopy = translation
                    translationCopy?.originalText = string

                    completion(translationCopy)
                }
            }
        }
        
    }
    
    // Write unit tests for this
    func translateOriginalText(text: String, completion: @escaping (String?) -> Void) {
        let langLocaleCode = LanguagePreferences.getLocaleLanguageCode()
        if langLocaleCode.uppercased() == "EN" {
            completion(text) // no need to translate an English word to English
        } else {
            GoogleTranslateAPI.getTranslation(for: text, sourceLanguage: "EN", targetLanguage: langLocaleCode) { (translation) in
                if let translation = translation {
                    completion(translation.translatedText)
                } else {
                    print("error on translateOriginalText")
                }
            }
        }
    }
}
