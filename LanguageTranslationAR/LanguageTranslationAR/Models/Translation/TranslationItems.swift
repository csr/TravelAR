//
//  TranslationItems.swift
//  LanguageTranslationAR
//

import Foundation

class TranslationItems {    
    static let shared = TranslationItems()
    
    private var set = Set<Translation>()
    
    // Public API
    
    public func add(object: Translation) {
        set.insert(object)
    }
    
    public func remove(object: Translation) {
        set.remove(object)
    }
    
    public func getAll() -> [Translation] {
        return Array(set)
    }
}
