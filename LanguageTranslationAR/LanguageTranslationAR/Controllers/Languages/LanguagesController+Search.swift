//
//  LanguagesController+Search.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 26/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension LanguagesController: UISearchResultsUpdating, UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        isFiltering = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        isFiltering = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        let langs = Array(tableViewSource.values.joined())
        
        let filteredLanguages = langs.filter({ (language) -> Bool in
            return self.filter(searchText: searchText, language: language)
        })
        
        (filteredTableViewHeaders, filteredTableViewSource) = createTableData(languagesList: filteredLanguages)
        
        tableView.reloadData()
    }
    
    private func filter(searchText: String, language: Language) -> Bool {
        if searchText.isEmpty {
            return true
        }
        
        return language.name.lowercased().starts(with: searchText.lowercased())
    }
}
