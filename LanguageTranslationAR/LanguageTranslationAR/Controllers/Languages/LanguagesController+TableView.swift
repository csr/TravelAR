//
//  LanguagesTableView+TableView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/12/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension LanguagesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let char = isFiltering ? filteredTableViewHeaders[indexPath.section] : tableViewHeaders[indexPath.section]
        let languages = isFiltering ? filteredTableViewSource[char] : tableViewSource[char]
        
        if let languages = languages {
            let language = languages[indexPath.row]
            selectedLanguage = language
        }
        
        didUpdateLanguageDelegate?.didUpdateLanguage()
        
        guard let selectedIndexPath = selectedIndexPath else {
            self.selectedIndexPath = indexPath
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            return
        }
        
        if indexPath == selectedIndexPath {
            return
        }
        
        // toggle old one off and the new one on
        let newCell = tableView.cellForRow(at: indexPath)
        newCell?.accessoryType = .checkmark

        let oldCell = tableView.cellForRow(at: selectedIndexPath)
        oldCell?.accessoryType = .none

        self.selectedIndexPath = indexPath
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return filteredTableViewHeaders.count
        } else {
            return tableViewHeaders.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .black
            view.tintColor = #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            let header = filteredTableViewHeaders[section]
            let values = filteredTableViewSource[header]
            return values?.count ?? 0
        } else {
            let header = tableViewHeaders[section]
            let values = tableViewSource[header]
            return values?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            let title = filteredTableViewHeaders[section]
            return String(title)
        } else {
            let title = tableViewHeaders[section]
            return String(title)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let key = isFiltering ? filteredTableViewHeaders[indexPath.section] : tableViewHeaders[indexPath.section]
        let values = isFiltering ? filteredTableViewSource[key] : tableViewSource[key]
        let language = values![indexPath.row]
        setupCell(cell: cell, language: language, indexPath: indexPath)
        return cell
    }
    
    func setupCell(cell: UITableViewCell, language: Language, indexPath: IndexPath) {
        cell.textLabel?.text = language.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black //UIColor(named: "cellBackground")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "selectedCell")
        cell.selectedBackgroundView = bgColorView

        if indexPath != selectedIndexPath {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
        if LanguagePreferences.getCurrent() == language {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        if selectedIndexPath == nil, language.code == LanguagePreferences.getCurrent().code {
            selectedIndexPath = indexPath
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var strings = [String]()
        for character in tableViewHeaders {
            strings.append(String(character))
        }
        return strings
    }
    
    func createTableData(languagesList: [Language]) -> (firstSymbols: [Character], source: [Character : [Language]]) {
        
        // Build Character Set
        var firstSymbols = Set<Character>()
        
        func getFirstSymbol(language: Language) -> Character {
            return language.name[language.name.startIndex]
        }
        
        languagesList.forEach {_ = firstSymbols.insert(getFirstSymbol(language: $0)) }
        
        // Build tableSourse array
        var tableViewSource = [Character : [Language]]()
        
        for symbol in firstSymbols {
            
            var languages = [Language]()
            
            for language in languagesList {
                if symbol == getFirstSymbol(language: language) {
                    languages.append(language)
                }
            }
            
            tableViewSource[symbol] = languages.sorted(by: { (language1, language2) -> Bool in
                return language1.name < language2.name
            })
        }
        
        let sortedSymbols = firstSymbols.sorted(by: {$0 < $1})
        
        return (sortedSymbols, tableViewSource)
    }
    
    func getTableData(languages: [Language]) {
        (tableViewHeaders, tableViewSource) = createTableData(languagesList: languages)
    }
}
