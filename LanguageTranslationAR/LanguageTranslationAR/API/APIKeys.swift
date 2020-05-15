//
//  APIKeys.swift
//  LanguageTranslationAR
//

import Foundation

enum APIKeys: String {
    
    case GoogleAPIKey
    
    // You can add any additional case you'd like here. The computed property below
    // takes the returns the contents of the {rawValue}.txt file at root level
    
    var value: String? {
        guard let path = Bundle.main.path(forResource: rawValue, ofType: "txt") else {
            print("Couldn't find the \(rawValue).txt file at root level.")
            return nil
        }
        
        do {
            let string = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            return string
        } catch {
            print("An error occured while loading the key:", error.localizedDescription)
            return nil
        }
    }
    
}
