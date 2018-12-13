//
//  SettingsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

protocol DidUpdateLanguage {
    func didUpdateLanguage()
}

class SettingsController: UITableViewController, DidUpdateLanguage {
    
    private let functionalData = FunctionalTableData()
    
    var chosenLanguage: String?
    var languages: [Language] = []
    
    var items: [Int: [String: String]] = [:] {
        didSet {
            render()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        didUpdateLanguage()
        getLanguages()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
    }
    
    private func setupForm() {
        let currentLanguage = LanguagePreferences.getCurrentLanguage()
        items[0] = ["text": "SETTINGS_TRANSLATE_TO".localized(),
                    "detailText": currentLanguage.name]

        functionalData.tableView = tableView
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
    
    private func render() {
        let cellStyle = CellStyle(bottomSeparator: .inset, separatorColor: .gray, backgroundColor: .black)
        
        let rows: [CellConfigType] = items.enumerated().map { index, item in
            let dict = items[index]
            
            return LabelCell(
                key: "id-\(index)",
                style: cellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        print("\(item) selected")
                        return .selected
                },
                    deselectionAction: { _ in
                        print("\(item) deselected")
                        return .deselected
                }),
                state: LabelState(dict: dict),
                cellUpdater: LabelState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
            ])
    }
}
