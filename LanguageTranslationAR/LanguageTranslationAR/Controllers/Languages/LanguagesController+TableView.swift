//
//  LanguagesTableView+TableView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/12/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension LanguagesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect cell at previous index path
        if let previousIndexPath = selectedIndexPath {
            tableView.cellForRow(at: previousIndexPath)?.accessoryType = .none
        }
        
        selectedIndexPath = indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        didUpdateLanguageDelegate?.didUpdateLanguage()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .black
            view.tintColor = #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1)
        }
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
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(named: "cellBackground")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "selectedCell")
        cell.selectedBackgroundView = bgColorView
        
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
}
