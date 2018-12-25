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
    var didUpdateLanguageDelegate: DidUpdateLanguage?
    
    var selectedIndexPath: IndexPath? {
        didSet {
            guard let index = selectedIndexPath else { return }
            let section = index.section
            let row = index.row
            let initialLetter = tableViewHeaders[section]
            if let values = tableViewSource[initialLetter] {
                let language = values[row]
                LanguagePreferences.save(language: language)
            }
        }
    }
    
    internal var filteredItems: [Character: [Language]] = [:] {
        didSet {
            self.tableView.reloadData()
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
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        self.tableView.reloadData()
    }
    
    
    @objc func didTapSaveBarButtonItem() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
        navigationController?.popViewController(animated: true)
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
        guard let text = searchController.searchBar.text else { return }

        print("search bar:", text)
        
        filteredItems = tableViewSource["text"]        
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
