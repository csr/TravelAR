//
//  DictionaryController+JSON.swift
//  testPlayground
//
//  Created by Cesare de Cal on 23/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
extension DictionaryController {
    internal func setupJSONFiles() {
        setupDictionaries()
    }
    
    internal func fetchJSON(for word: String, source_lang: String) {
        let urlString = "https://od-api.oxforddictionaries.com/api/v1/entries/en/" + word + "/definitions;lexicalCategory=noun;regions=us"
        let appKey = "4dbd0d07dbcdea369dec5dc3e81a2bb9"
        let appId = "4b991cea"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(appKey, forHTTPHeaderField: "app_key")
        urlRequest.setValue(appId, forHTTPHeaderField: "app_id")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    print("Failed to get data from URL:", err)
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let entry = try decoder.decode(DictionaryEntry.self, from: data)
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
    
    internal func getDictionaryEntry(language: Language, word: String) -> (key: String, definition: String)? {
        guard let dictionary = translationDict[language.languageCode] else { return nil }
        let words = Array(word.split(separator: " "))
        for oneWord in words {
            for (key, definition) in dictionary {
                if key == oneWord {
                    return (key, definition)
                }
            }
        }
        return nil
    }
    
    private func setupDictionaries() {
        for language in Languages.getAll() {
            translationDict[language.languageCode] = getDictionaryFromJSON(named: language.languageCode)
        }
    }
    
    private func getDictionaryFromJSON(named name: String) -> [String: String] {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, String> {
                    return jsonResult
                }
            } catch {
                print("error while opening dictionary JSON file")
            }
        }
        return [:]
    }
}
