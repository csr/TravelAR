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
        guard let path = Bundle.main.path(forResource: rawValue, ofType: "txt") else {
            print("⚠️ I couldn't find the Cloud Translation key. Please include the GoogleAPIKey.txt file in the main directory.")
            return ""
        }
        do {
            let string = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return string
        } catch {
            print("An error occured while loading the key:", error)
        }
        return ""
    }
    
}
