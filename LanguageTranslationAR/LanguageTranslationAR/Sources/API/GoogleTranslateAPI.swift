//
//  GoogleTranslateAPI.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 30/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

class GoogleTranslateAPI {
    class func getTranslations(for text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping([Translation]) -> Void) {
        print("Processing translation request...")
        let session = URLSession(configuration: .default)
        let urlStr = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=\(targetLanguage)&key=\(Keys.googleAPIKey)"
        print("url str", urlStr)
        guard let escapedString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: escapedString) else {
            print("Error: invalid url while getting translation")
            completion([])
            return
        }
        
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                if let languageData = try? JSONDecoder().decode(TranslationData.self, from: data) {
                    completion(languageData.data.translations)
                } else {
                    print("Error while decoding translation data")
                }
            } else {
                print("Error: data nil")
                completion([])
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