//
//  NSMutableStringExtensions.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/14/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

// An attributed string extension to achieve colors on text.
extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
