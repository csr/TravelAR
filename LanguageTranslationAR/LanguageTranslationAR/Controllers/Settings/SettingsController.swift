//
//  SettingsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

protocol DidUpdateLanguage {
    func didUpdateLanguage()
}

class SettingCell: UITableViewCell {
    
}

class SettingsController: UITableViewController, DidUpdateLanguage {

    var chosenLanguage: String?
    var languages: [Language] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didUpdateLanguage()
        getLanguages()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
    }
    
    func getLanguages() {
        let languageCode = LanguagePreferences.getLocaleLanguageCode()
        GoogleTranslateAPI.getLanguages(targetLanguage: languageCode) { (languages) in
            self.languages = languages
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let languagesController = LanguagesTableViewController()
        languagesController.didUpdateLanguageDelegate = self
        languagesController.getTableData(languages: languages)
        navigationController?.pushViewController(languagesController, animated: true)
    }
    
    func didUpdateLanguage() {
        let language = LanguagePreferences.getCurrentLanguage()
        chosenLanguage = language.name
        tableView.reloadData()
    }
}
