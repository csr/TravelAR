//
//  Language.swift
//  LanguageTranslationAR
//

import Foundation

struct Language: Codable, Equatable {
    var name: String
    var code: String
        
    static func ==(lhs: Language, rhs: Language) -> Bool {
        return lhs.code == rhs.code
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case code = "language"
    }
}
