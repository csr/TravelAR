//
//  CardsController+Data.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/30/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension CardsController {
    func loadJSONFile(fileName: String) -> [String: AnyObject]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    return jsonResult
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
