//
//  LanguagesTableViewController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 6/8/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class LanguagesTableViewController: UITableViewController {
    
    var tableViewSource = [Character: [Language]]()
    var tableViewHeaders = [Character]()
    
    var didUpdateLanguageDelegate: DidUpdateLanguage?
    
    var selectedIndexPath: IndexPath? {
        didSet {
            // Save language
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
    
    func createTableData(languagesList: [Language]) -> (firstSymbols: [Character], source: [Character : [Language]]) {
        
        // Build Character Set
        var firstSymbols = Set<Character>()
        
        func getFirstSymbol(language: Language) -> Character {
            return language.name[language.name.startIndex]
        }
        
        languagesList.forEach {_ = firstSymbols.insert(getFirstSymbol(language: $0)) }
        
        // Build tableSourse array
        var tableViewSourse = [Character : [Language]]()
        
        for symbol in firstSymbols {
            
            var languages = [Language]()
            
            for language in languagesList {
                if symbol == getFirstSymbol(language: language) {
                    languages.append(language)
                }
            }
            
            tableViewSourse[symbol] = languages.sorted(by: { (language1, language2) -> Bool in
                return language1.name < language2.name
            })
        }
        
        let sortedSymbols = firstSymbols.sorted(by: {$0 < $1})
        
        return (sortedSymbols, tableViewSourse)
    }
    
    func getTableData(languages: [Language]) {
        tableViewSource = createTableData(languagesList: languages).source
        tableViewHeaders = createTableData(languagesList: languages).firstSymbols
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToUserLanguage()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "SETTINGS_TRANSLATE_TO".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        setupActivityIndicator()
        getData()
    }
    
    internal func setupActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func getData() {
        self.tableView.reloadData()
        self.scrollToUserLanguage()
    }
    
    @objc func didTapSaveBarButtonItem() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
        navigationController?.popViewController(animated: true)
    }
}
