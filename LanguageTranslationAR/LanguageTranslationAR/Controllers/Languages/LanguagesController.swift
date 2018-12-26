//
//  LanguagesController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 6/8/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class LanguagesController: UITableViewController {
    
    var tableViewSource = [Character: [Language]]()
    var tableViewHeaders = [Character]()
    
    var filteredTableViewSource = [Character: [Language]]()
    var filteredTableViewHeaders = [Character]()
    
    var didUpdateLanguageDelegate: DidUpdateLanguage?
    
    var selectedLanguage: Language? {
        didSet {
            LanguagePreferences.save(language: selectedLanguage)
        }
    }
    
    var isFiltering = false
    
    let cellId = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchController()
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        self.navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        tableView.reloadData()
    }
    
    @objc func didTapSaveBarButtonItem() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
        navigationController?.popViewController(animated: true)
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

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
