//
//  LanguagesTableView+TableView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/12/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension LanguagesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect cell at previous index path
        if let previousIndexPath = selectedIndexPath {
            tableView.cellForRow(at: previousIndexPath)?.accessoryType = .none
        }
        
        selectedIndexPath = indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
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
        cell.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.09019607843, blue: 0.09411764706, alpha: 1)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1)
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
}
