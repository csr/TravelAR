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
        guard let text = searchController.searchBar.text, let firstChar = text.first, let langs = tableViewSource[firstChar] else { return }
        
        let filteredLanguages = langs.filter({ (language) -> Bool in
            return language.name.lowercased().contains(text.lowercased())
        })
        
        (filteredTableViewHeaders, filteredTableViewSource) = createTableData(languagesList: filteredLanguages)
        
        tableView.reloadData()
    }
}
