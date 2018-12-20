//
//  String+Localization.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 10/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        let localizationText = NSLocalizedString(self, comment: "")
        guard !localizationText.isEmpty else {
            return self
        }
        
        return localizationText
    }
}
