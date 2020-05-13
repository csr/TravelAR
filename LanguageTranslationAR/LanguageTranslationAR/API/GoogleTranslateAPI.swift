//
//  GoogleTranslateAPI.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 30/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

class GoogleTranslateAPI {
    class func getTranslation(for text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping(Translation?) -> Void) {
        let session = URLSession(configuration: .default)
        let apiKey = Keys.GoogleAPIKey.value
        
        let url = "https://translation.googleapis.com/language/translate/v2"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                if let languageData = try? JSONDecoder().decode(TranslationData.self, from: data), let translation = languageData.data.translations.first {
                    var transl = translation
                    transl.targetLanguage = targetLanguage
                    transl.originalText = text
                    completion(transl)
                } else {
                    print("Error while decoding translation data. body:", String(data: data, encoding: .utf8)!)
                }
            }
            completion(nil)
        }.resume()
    }
    
    class func getAvailableLanguages(targetLanguage: String, completion: @escaping ([Language]) -> Void) {
        let session = URLSession(configuration: .default)
        let apiKey = Keys.GoogleAPIKey.value
        
        let url = "https://translation.googleapis.com/language/translate/v2/languages"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "key", value: apiKey)
        ]

        let request = URLRequest(url: components.url!)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                let languageData = try? decoder.decode(LanguageData.self, from: data)
                completion(languageData?.data.languages ?? [])
            } else {
                print("Could not parse getAvailableLanguages data")
                completion([])
            }
        }.resume()
    }
}
