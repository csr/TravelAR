//
//  LanguagePreferences.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal & Giuliano on 16/06/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

class LanguagePreferences {
    
    static var languages = [Language]()
    
    class func getCurrent() -> Language {
        let defaults = UserDefaults.standard
        if let code = defaults.string(forKey: "languageCode"), let name = defaults.string(forKey: "languageName") {
            return Language(name: name, languageCode: code)
        } else {
            return Language(name: "Spanish", languageCode: "es")
        }        
    }
    
    class func save(language: Language) {
        let defaults = UserDefaults.standard
        defaults.set(language.name, forKey: "languageName")
        defaults.set(language.languageCode, forKey: "languageCode")
    }
    
    class func getLocaleLanguageCode() -> String {
        return Locale.current.languageCode ?? "en"
    }
}
