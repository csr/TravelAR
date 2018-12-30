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
    var code: String
        
    static func ==(lhs: Language, rhs: Language) -> Bool {
        return lhs.code == rhs.code
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case code = "language"
    }
}
