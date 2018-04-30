//
//  GoogleTranslateAPI.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 30/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

class GoogleTranslateAPI {
    class func getLanguages(target_language: String, completion: @escaping ([Language]) -> Void) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?target=\(target_language)&key=\(Keys.googleAPIKey)") else { return }
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
