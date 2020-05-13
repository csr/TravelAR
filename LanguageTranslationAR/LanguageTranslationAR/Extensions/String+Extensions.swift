//
//  String+Extensions.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 10/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

extension String {
    
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }

    
    // MARK: - Localization
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    public func localizedString(with arguments: [CVarArg]) -> String {
        return String(format: localized, arguments: arguments)
    }
}
