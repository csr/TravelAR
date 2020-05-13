//
//  GoogleTranslateAPI.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 30/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class GoogleTranslateAPI {
    
    static let shared = GoogleTranslateAPI()
    
    func getTranslation(for text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping (Result<Translation, NetworkError>) -> Void) {
        let apiKey = APIKeys.GoogleAPIKey.value
        let url = "https://translation.googleapis.com/language/translate/v2"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data, let languageData = try? JSONDecoder().decode(TranslationData.self, from: data), var translation = languageData.data.translations.first {
                translation.targetLanguage = targetLanguage
                translation.originalText = text
                
                // Decode characters such as '&#8216' into readable UTF-8 characters (accents, symbols, etc.)
                translation.translatedText = String(htmlEncodedString: translation.translatedText) ?? ""
                
                completion(.success(translation))
            } else {
                completion(.failure(.error))
            }
        }.resume()
    }
    
    func getAvailableLanguages(targetLanguage: String, completion: @escaping (Result<[Language], NetworkError>) -> Void) {
        let session = URLSession(configuration: .default)
        let apiKey = APIKeys.GoogleAPIKey.value
        
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
            
            if let data = data, let languageData = try? JSONDecoder().decode(LanguageData.self, from: data) {
                completion(.success(languageData.data.languages))
            } else {
                completion(.failure(.error))
            }
        }.resume()
    }
}
