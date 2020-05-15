//
//  LanguagePreferences.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 16/06/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation
import Flags

class LanguagePreferences {
        
    class func getCurrent() -> Language {
        let defaults = UserDefaults.standard
        if let code = defaults.string(forKey: "languageCode"), let name = defaults.string(forKey: "languageName") {
            return Language(name: name, code: code)
        } else {
            return Language(name: "Spanish", code: "es")
        }        
    }
    
    class func save(language: Language) {        
        let defaults = UserDefaults.standard
        defaults.set(language.name, forKey: "languageName")
        defaults.set(language.code, forKey: "languageCode")
    }
    
    class func getLocaleLanguageCode() -> String {
        return Locale.current.languageCode ?? "en"
    }
    
    class func getEmoji(for langCode: String) -> String? {
        return Flag(countryCode: langCode)?.emoji
    }
}
