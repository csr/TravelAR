//
//  LanguagesTableViewController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 6/8/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

protocol LanguageSelectionDelegate {
    func didSelectLanguage(language: Language)
}

class LanguagesTableViewController: UITableViewController {
    
    var tableViewSource = [Character: [Language]]()
    var tableViewHeaders = [Character]()
    
    var letterArray = [String]()
    var sortedLanguages = [String: Language]()
    
    var delegate: LanguageSelectionDelegate?
    
    var selectedLanguage: Language? {
        didSet {
            
        }
    }
    
    let cellId = "reuseIdentifier"

    var selectedCell: UITableViewCell? {
        willSet {
            /*
            selectedCell?.accessoryType = .none
            newValue?.accessoryType = .checkmark
            if let cell = selectedCell {
                let index = tableView.indexPath(for: cell)
                if let row = index?.row {
                    //let language = languages[row]
                    //delegate?.didSelectLanguage(language: language)
                }
            }
 */
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = self.tableView.cellForRow(at: indexPath)
        self.tableView.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        title = "Translation Language"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapOnCloseItem))
        getData()
    }
    
    func getData() {
        GoogleTranslateAPI.getLanguages(targetLanguage: "en") { (languages) in
            DispatchQueue.main.async {
                self.getTableData(languages: languages)
                self.tableView.reloadData()
            }
        }
    }
    
    func storeData() {
        // Store languages data in Core Data
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
        /*
        let section = tableViewSource[indexPath.section]
        let language = section[indexPath.row]
        
        cell.textLabel?.text = language.name
        
        
        if cell == selectedCell {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

 */
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let key = tableViewHeaders[indexPath.section]
        let values = tableViewSource[key]
        let language = values![indexPath.row]
        cell.textLabel?.text = language.name
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 19)
        cell.textLabel?.font = font
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
