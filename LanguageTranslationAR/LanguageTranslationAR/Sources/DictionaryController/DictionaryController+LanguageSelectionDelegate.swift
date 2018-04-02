//
//  DictionaryController+LanguageSelectionDelegate.swift
//  testPlayground
//
//  Created by Cesare de Cal on 23/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
extension DictionaryController: LanguageSelectionDelegate {
    func didSelectLanguage(language: Language) {
        selectedLanguage = language
    }
}
