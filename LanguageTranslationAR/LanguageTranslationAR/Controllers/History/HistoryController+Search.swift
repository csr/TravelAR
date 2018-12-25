//
//  HistoryController+Search.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 25/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension HistoryController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        isFiltering = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        isFiltering = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        filteredItems = TranslationItems.shared.getAll().filter { (translation) -> Bool in
            return filter(searchText: text, translation: translation)
        }
        
        render()
    }
    
    private func filter(searchText: String, translation: Translation) -> Bool {
        if searchText.isEmpty {
            return true
        }
        
        if let originalText = translation.originalText, originalText.lowercased().contains(searchText.lowercased()) {
            return true
        }
        
        return translation.translatedText.lowercased().contains(searchText.lowercased())
    }
}
