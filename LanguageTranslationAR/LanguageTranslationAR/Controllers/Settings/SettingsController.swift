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
    private var items: [String] = [] {
        didSet {
            render()
        }
    }
    
    var chosenLanguage: String?
    var languages: [Language] = []
    var myDictionary: [Int: [String: String]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        items.append("Translate to")
        
        didUpdateLanguage()
        getLanguages()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
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
        let rows: [CellConfigType] = items.enumerated().map { index, item in
            return LabelCell(
                key: "id-\(index)",
                actions: CellActions(
                    selectionAction: { _ in
                        print("\(item) selected")
                        return .selected
                },
                    deselectionAction: { _ in
                        print("\(item) deselected")
                        return .deselected
                }),
                state: LabelState(text: item),
                cellUpdater: LabelState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
            ])
    }
}
