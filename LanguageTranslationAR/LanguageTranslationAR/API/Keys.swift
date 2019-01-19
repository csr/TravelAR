//
//  Keys.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 1/18/19.
//  Copyright © 2019 Cesare de Cal. All rights reserved.
//

import Foundation

enum Keys: String {
    case GoogleAPIKey
    var value: String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(rawValue)
            do {
                let key = try String(contentsOf: fileURL, encoding: .utf8)
                return key
            }
            catch {
                print("An error occured while loading the key")
            }
        }
        return ""
    }
    
}
