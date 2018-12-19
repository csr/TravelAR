//
//  Translation.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

public struct Translation: Codable, Equatable {
    var key: String
    var originalText: String?
    var targetLanguage: String?
    var translatedText: String
    var sourceLanguage: String
    
    init(originalText: String? = nil, targetLanguage: String? = nil, translatedText: String, sourceLanguage: String) {
        self.key = NSUUID().uuidString
        self.originalText = originalText
        self.targetLanguage = targetLanguage
        self.translatedText = translatedText
        self.sourceLanguage = sourceLanguage
    }
    
    private enum CodingKeys: String, CodingKey {
        case key
        case translatedText
        case sourceLanguage = "detectedSourceLanguage"
    }
}
