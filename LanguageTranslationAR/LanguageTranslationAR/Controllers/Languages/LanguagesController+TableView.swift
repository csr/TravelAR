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
        
        let char = tableViewHeaders[indexPath.section]
        let languages = tableViewSource[char]
        
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
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .black
            view.tintColor = #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = tableViewHeaders[section]
        let values = tableViewSource[header]
        return values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = tableViewHeaders[section]
        return String(title)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let key = tableViewHeaders[indexPath.section]
        let values = tableViewSource[key]
        let language = values![indexPath.row]
        setupCell(cell: cell, language: language, indexPath: indexPath)
        return cell
    }
    
    func setupCell(cell: UITableViewCell, language: Language, indexPath: IndexPath) {
        cell.textLabel?.text = language.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.cell
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
        
    func createTableData(languagesList: [Language]) -> (firstSymbols: [String], source: [String: [Language]]) {
        
        // Build Character Set
        var firstSymbols = Set<Character>()
        
        func getFirstSymbol(language: Language) -> Character {
            return language.name[language.name.startIndex]
        }
        
        languagesList.forEach {_ = firstSymbols.insert(getFirstSymbol(language: $0)) }
        
        // Build tableSource array
        var tableViewSource = [String: [Language]]()
        
        for symbol in firstSymbols {
            
            var languages = [Language]()
            
            for language in languagesList {
                if symbol == getFirstSymbol(language: language) {
                    languages.append(language)
                }
            }
            
            let symbolStr = String(symbol)
            
            tableViewSource[symbolStr] = languages.sorted(by: { (language1, language2) -> Bool in
                return language1.name < language2.name
            })
            
        }
        
        var charToStrArray = [String]()
        for symbol in firstSymbols {
            let symbolStr = String(symbol)
            charToStrArray.append(symbolStr)
        }
        
        var sortedSymbolsStr = [String]()
        sortedSymbolsStr = charToStrArray.sorted(by: { (char1, char2) -> Bool in
            let char1Str = String(char1)
            let char2Str = String(char2)
            return char1Str < char2Str
        })
        
        
        let popularStr = "POPULAR".localized
        tableViewSource[popularStr] = []
        sortedSymbolsStr.insert(popularStr, at: 0)
        
        let popularLangCodes = ["es", "en", "it", "de", "ru", "fr", "zh"]
        
        for language in languagesList {
            if popularLangCodes.contains(language.code.lowercased()) && language.code.lowercased() != LanguagePreferences.getLocaleLanguageCode().lowercased() {
                if let array = tableViewSource[popularStr] {
                    var finalArray = array
                    finalArray.append(language)
                    tableViewSource[popularStr] = finalArray
                } else {
                    tableViewSource[popularStr] = [language]
                }
            }
        }
        
        if let array = tableViewSource[popularStr] {
            tableViewSource[popularStr] = array.sorted(by: {$0.name < $1.name})
        }
        
        return (sortedSymbolsStr, tableViewSource)
    }
}
