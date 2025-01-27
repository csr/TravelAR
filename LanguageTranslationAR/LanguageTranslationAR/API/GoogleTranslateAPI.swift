//
//  GoogleTranslateAPI.swift
//  LanguageTranslationAR
//

import UIKit

class GoogleTranslateAPI {
    
    static let shared = GoogleTranslateAPI()
    
    func getTranslation(for text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping (Result<Translation, NetworkError>) -> Void) {
        let apiKey = APIKeys.GoogleAPIKey.value
        
        let url = "https://translation.googleapis.com/language/translate/v2"
        
        guard var components = URLComponents(string: url) else {
            completion(.failure(.malformedRequest))
            return
        }
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let componentsUrl = components.url else {
            completion(.failure(.networkError))
            return
        }
        
        let request = URLRequest(url: componentsUrl)
        
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
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    func getAvailableLanguages(targetLanguage: String, completion: @escaping (Result<[Language], NetworkError>) -> Void) {
        let session = URLSession(configuration: .default)
        let apiKey = APIKeys.GoogleAPIKey.value
        
        let url = "https://translation.googleapis.com/language/translate/v2/languages"
        
        guard var components = URLComponents(string: url) else {
            completion(.failure(.malformedRequest))
            return
        }
        components.queryItems = [
            URLQueryItem(name: "target", value: targetLanguage),
            URLQueryItem(name: "key", value: apiKey)
        ]

        guard let componentsUrl = components.url else {
            completion(.failure(.networkError))
            return
        }
        
        let request = URLRequest(url: componentsUrl)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data, let languageData = try? JSONDecoder().decode(LanguageData.self, from: data) {
                completion(.success(languageData.data.languages))
            } else {
                completion(.failure(.networkError))
            }
        }.resume()
    }
}
