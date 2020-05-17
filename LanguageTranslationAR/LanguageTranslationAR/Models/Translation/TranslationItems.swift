//
//  TranslationItems.swift
//  LanguageTranslationAR
//

import Foundation

class TranslationItems {
    var delegate: TranslationItemsDelegate?
    
    static let shared = TranslationItems()
    
    private var set = Set<Translation>()
    
    // Public API
    
    public func add(object: Translation) {
        set.insert(object)
        delegate?.newItemAdded()
    }
    
    public func remove(object: Translation) {
        set.remove(object)
        delegate?.someItemDeleted()
    }
    
    public func getAll() -> [Translation] {
        return Array(set)
    }
}
