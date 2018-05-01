//
//  DictionaryController+API.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension DictionaryController {
    internal func getTranslations(text: String, completion: @escaping ([Translation]) -> Void) {
        print("Sent translation request...")

        GoogleTranslateAPI.getTranslations(for: text, sourceLanguage: getSourceLanguageCode(), targetLanguage: selectedLanguage?.languageCode ?? "es") { (translations) in
            print("Got translations #:", translations.count)
            completion(translations)
        }
    }
    
    internal func getSourceLanguageCode() -> String {
        return Locale.current.languageCode ?? "en"
    }
    
    internal func loadLanguages() {
        GoogleTranslateAPI.getLanguages(targetLanguage: getSourceLanguageCode()) { (languages) in
            self.languages = languages
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }
}
