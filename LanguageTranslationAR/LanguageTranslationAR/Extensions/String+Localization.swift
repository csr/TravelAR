//
//  String+Localization.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 10/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    public func localizedString(with arguments: [CVarArg]) -> String {
        return String(format: localized, arguments: arguments)
    }
}
