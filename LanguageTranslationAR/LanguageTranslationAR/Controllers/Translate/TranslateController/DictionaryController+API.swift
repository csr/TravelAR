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
        let userLanguage = LanguagePreferences.getCurrent()
        GoogleTranslateAPI.getTranslation(for: text, sourceLanguage: LanguagePreferences.getLocaleLanguageCode(), targetLanguage: userLanguage.languageCode) { (translation) in
            completion(translation)
        }
    }
}
