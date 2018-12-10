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
    var selectedIndexPath: IndexPath? {
        didSet {
            // Save language
            guard let index = selectedIndexPath else { return }
            let section = index.section
            let row = index.row
            let initialLetter = tableViewHeaders[section]
            if let values = tableViewSource[initialLetter] {
                let language = values[row]
                LanguagePreferences.saveLanguage(language: language)
            }
        }
    }
    
    let cellId = "reuseIdentifier"
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
            
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
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
        let userLanguage = LanguagePreferences.getCurrentLanguage()
        
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
        title = NSLocalizedString("Translation Language", comment: "Translation Language")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapOnCloseItem))
        tableView.tableFooterView = UIView()
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
        let languageCode = LanguagePreferences.getLocaleLanguageCode()
        GoogleTranslateAPI.getLanguages(targetLanguage: languageCode) { (languages) in
            DispatchQueue.main.async {
                self.getTableData(languages: languages)
                self.tableView.reloadData()
                self.scrollToUserLanguage()
            }
        }
    }
    
    @objc func didTapOnCloseItem() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = tableViewHeaders[section]
        let values = tableViewSource[header]
        return values?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = tableViewHeaders[section]
        return String(title)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let key = tableViewHeaders[indexPath.section]
        let values = tableViewSource[key]
        let language = values![indexPath.row]
        cell.textLabel?.text = language.name
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 19)
        cell.textLabel?.font = font
        
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var strings = [String]()
        for character in tableViewHeaders {
            strings.append(String(character))
        }
        return strings
    }
}
