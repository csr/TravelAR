//
//  Language.swift
//  testPlayground
//
//  Created by Cesare de Cal on 23/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import Foundation

struct Language: Equatable {
    var name: String
    var languageCode: String
    var emoji: Character
    
    func getDescription() -> String {
        return "\(name) \(emoji)"
    }
    
    static func ==(lhs: Language, rhs: Language) -> Bool {
        return lhs.name == rhs.name
    }
}


