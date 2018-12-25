//
//  LanguageTableViewController+Search.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 6/10/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension LanguagesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//            filteredNFLTeams = unfilteredNFLTeams.filter { team in
//                return team.lowercased().contains(searchText.lowercased())
//            }
//
        } else {
            //filteredNFLTeams = unfilteredNFLTeams
        }
        tableView.reloadData()
    }
}
