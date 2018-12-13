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
    
    var languages: [Language] = []
    
    var items: [Int: [String: String]] = [:] {
        didSet {
            render()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        functionalData.tableView = tableView
        updateForm()
        didUpdateLanguage()
        getLanguages()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
    }
    
    private func updateForm() {
        let currentLanguage = LanguagePreferences.getCurrentLanguage()
        items[0] = ["text": "SETTINGS_TRANSLATE_TO".localized(),
                    "detailText": currentLanguage.name]
        render()
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
        updateForm()
    }
    
    private func didSelectTranslationLanguage() {
        let languagesController = LanguagesTableViewController()
        languagesController.didUpdateLanguageDelegate = self
        languagesController.getTableData(languages: languages)
        navigationController?.pushViewController(languagesController, animated: true)
        
    }
    
    func didUpdateLanguage() {
        updateForm()
    }
    
    private func render() {
        
        let cellStyle = CellStyle(bottomSeparator: .inset, separatorColor: .gray, highlight: false, accessoryType: .disclosureIndicator, selectionColor: #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1), backgroundColor: .black, backgroundView: nil, tintColor: nil, layoutMargins: nil, cornerRadius: 0)
        
        let rows: [CellConfigType] = items.enumerated().map { index, item in
            let dict = items[index]
            return LabelCell(
                key: "id-\(item.key)",
                style: cellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.didSelectTranslationLanguage()
                        return .deselected
                },
                    deselectionAction: { _ in
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
