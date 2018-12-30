//
//  HistoryController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 07/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData
import TBEmptyDataSet

class HistoryController: UITableViewController, TranslationItemsDelegate {
    internal let functionalData = FunctionalTableData()
    
    internal var filteredItems: [Translation] = [] {
        didSet {
            render()
        }
    }

    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TranslationItems.shared.delegate = self
        setupView()
        setupSearchController()
        render()
        
        if Testing.isTesting {
            populateWithDemoData()
        }
    }
    
    private func populateWithDemoData() {
        let languagesToTranslateTo = ["ar", "be", "am", "hr", "nl", "es", "ch", "ro", "ne"]        
        for i in 1...9 {
            let targetLanguage = languagesToTranslateTo[i-1]
            let originalText = "ORIGINAL_TEXT_\(i)".localized
            let sourceLanguage = LanguagePreferences.getLocaleLanguageCode()
            
            GoogleTranslateAPI.getTranslation(for: originalText, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage) { (translation) in
                if let translation = translation {
                    TranslationItems.shared.add(object: translation)
                    self.render()
                }
            }
        }
    }
    
    @objc private func test() {
        let navController = UINavigationController(rootViewController: WelcomeController())
        present(navController, animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        functionalData.tableView = tableView
        tableView.emptyDataSetDataSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        self.navigationItem.searchController = search
    }
}
