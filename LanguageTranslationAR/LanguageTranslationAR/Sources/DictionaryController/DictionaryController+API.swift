//
//  DictionaryController+API.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension DictionaryController {
    internal func getTranslation(text: String, completion: @escaping (Translation?) -> Void) {
        print("Sent translation request...")

        GoogleTranslateAPI.getTranslation(for: text, sourceLanguage: getSourceLanguageCode(), targetLanguage: selectedLanguage.languageCode) { (translation) in
            completion(translation)
        }
    }
    
    internal func getSourceLanguageCode() -> String {
        return Locale.current.languageCode ?? "en"
    }    
}
