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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didUpdateLanguage()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
//        tableView.register(SettingCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath
//        cell.backgroundColor = .black
//        cell.textLabel?.textColor = .white
//        cell.detailTextLabel?.text = chosenLanguage
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let languagesController = LanguagesTableViewController()
        languagesController.didUpdateLanguageDelegate = self
        navigationController?.pushViewController(languagesController, animated: true)
    }
    
    func didUpdateLanguage() {
        let language = LanguagePreferences.getCurrentLanguage()
        chosenLanguage = language.name
        tableView.reloadData()
    }
}
