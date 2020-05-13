//
//  Keys.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 1/18/19.
//  Copyright © 2019 Cesare de Cal. All rights reserved.
//

import Foundation

enum APIKeys: String {
    
    case googleCloud
    
    // You can add any additional case you'd like here. The computed property below
    // takes the value as input and files the {rawValue}.txt file at root level
    
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
