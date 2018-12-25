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
    
    let cellId = "reuseIdentifier"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //scrollToUserLanguage()
    }
    
    func scrollToUserLanguage() {
        let userLanguage = LanguagePreferences.getCurrent()
        
        let nestedArr = Array(tableViewSource.values)
        let allLangs = nestedArr.reduce([], +)
        
        if let index = allLangs.index(of: userLanguage) {
            let language = allLangs[index]
            let name = language.name
            let initialLetter = name.first ?? " "
            let languagesWithInitial = tableViewSource[initialLetter]
            if let sectionNumber = tableViewHeaders.index(of: initialLetter), let rowNumber = languagesWithInitial?.index(of: language) {
                let indexPath = IndexPath(row: rowNumber, section: sectionNumber)
                self.tableView.reloadData()
                tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
                selectedIndexPath = indexPath
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
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
        //navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func getData() {
        self.tableView.reloadData()
        //self.scrollToUserLanguage()
    }
    
    @objc func didTapSaveBarButtonItem() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
        navigationController?.popViewController(animated: true)
    }
}

extension LanguagesController: UISearchControllerDelegate {
}
