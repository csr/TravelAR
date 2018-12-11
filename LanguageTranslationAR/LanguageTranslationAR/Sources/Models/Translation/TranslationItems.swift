//
//  TranslationItems.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 11/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation

protocol ItemsDelegate {
    func newItemAdded()
}

class TranslationItems {
    var delegate: ItemsDelegate?
    
    static let shared = TranslationItems()
    var array = [Translation]() {
        didSet {
            delegate?.newItemAdded()
        }
    }
}
