//
//  Language.swift
//  testPlayground
//
//  Created by Cesare de Cal on 23/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import Foundation

struct Language: Codable, Equatable {
    var name: String
    var languageCode: String
        
    static func ==(lhs: Language, rhs: Language) -> Bool {
        return lhs.languageCode == rhs.languageCode
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case languageCode = "language"
    }
}
