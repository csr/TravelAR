//
//  Translation.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

struct Translation: Codable, Equatable {
    var originalText: String?
    var targetLanguage: String?
    var translatedText: String
    var sourceLanguage: String
    
    private enum CodingKeys: String, CodingKey {
        case translatedText
        case sourceLanguage = "detectedSourceLanguage"
    }
}

