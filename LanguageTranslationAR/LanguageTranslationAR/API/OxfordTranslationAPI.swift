//
//  OxfordTranslationAPI.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/30/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

class OxfordTranslationAPI {
    class func getTranslationWithExamples(for text: String, sourceLanguage: String, targetLanguage: String, completion: @escaping(Translation?) -> Void) {
        let appId = APIKeys.oxfordAppID
        let appKey = APIKeys.oxfordDictionaries
        let language = sourceLanguage
        let target_lang = targetLanguage
        let word = text
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        
        let rawString = "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)/translations=\(target_lang)"
        guard let escapedString = rawString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: escapedString) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                print("ok got the following from Oxford data:", data)
                
//                if let languageData = try? JSONDecoder().decode(TranslationData.self, from: data), let translation = languageData.data.translations.first {
//                    var transl = translation
//                    transl.targetLanguage = targetLanguage
//                    transl.originalText = text
//                    completion(transl)
//                } else {
//                    print("Error while decoding translation data")
//                }
            } else {
                print("Error: data nil")
                completion(nil)
            }
        }).resume()
    }
    
    class func isTranslationSupported(sourceLanguageCode: String, targetLanguageCode: String) -> Bool {
        let supportedLanguages = ["es", "en", "nso", "zu", "ms", "id", "tn", "ur", "de", "pt"]
        return false //supportedLanguages.contains(sourceLanguageCode) && supportedLanguages.contains(targetLanguageCode)
    }
}
