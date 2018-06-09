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

    let cellId = "reuseIdentifier"
    var languages = [Language]()
    var delegate: LanguageSelectionDelegate?
    
    var selectedCell: UITableViewCell? {
        willSet{
            selectedCell?.accessoryType = .none
            newValue?.accessoryType = .checkmark
            if let cell = selectedCell {
                let index = tableView.indexPath(for: cell)
                if let row = index?.row {
                    let language = languages[row]
                    delegate?.didSelectLanguage(language: language)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = self.tableView.cellForRow(at: indexPath)
        self.tableView.reloadData()
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
            self.languages = languages
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.storeData()
            }
        }
    }
    
    func storeData() {
        // Store data in Core Data
    }
    
    @objc func didTapOnCloseItem() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let language = languages[indexPath.row]
        cell.textLabel?.text = language.name
        
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 19)
        cell.textLabel?.font = font
        
        if cell == selectedCell {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
