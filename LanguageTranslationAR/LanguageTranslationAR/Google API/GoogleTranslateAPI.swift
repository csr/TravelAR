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
        let urlStr = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=\(targetLanguage)&key=\(Keys.googleAPIKey)"
        guard let escapedString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: escapedString) else {
            print("Error: invalid URL while getting translation")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                if let languageData = try? JSONDecoder().decode(TranslationData.self, from: data), let translation = languageData.data.translations.first {
                    var transl = translation
                    transl.targetLanguage = targetLanguage
                    transl.originalText = text
                    //transl.key = NSUUID().uuidString
                    completion(transl)
                } else {
                    print("Error while decoding translation data")
                }
            } else {
                print("Error: data nil")
                completion(nil)
            }
        }.resume()
    }
    
    class func getLanguages(targetLanguage: String, completion: @escaping ([Language]) -> Void) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?target=\(targetLanguage)&key=\(Keys.googleAPIKey)") else {
            print("error: invalid URL while getting languages")
            return
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                let languageData = try? decoder.decode(LanguageData.self, from: data)
                completion(languageData?.data.languages ?? [])
            } else {
                print("Could not parse data")
            }
        }.resume()
    }
}
