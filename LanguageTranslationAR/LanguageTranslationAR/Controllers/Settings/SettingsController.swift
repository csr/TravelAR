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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        functionalData.tableView = tableView
        render()
        didUpdateLanguage()
        getLanguages()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
    }
    
    // Primary cell states include the "Translate To" row
    private func getPrimaryCellStates() -> [LabelState] {
        let currentLanguage = LanguagePreferences.getCurrentLanguage()
        print("getting current language:", currentLanguage.name)
        let translateCellState = LabelState(text: "SETTINGS_TRANSLATE_TO".localized(), detailText: currentLanguage.name, imageName: "translate", imageBgColor: .red)
        return [translateCellState]
    }
    
    private func getSecondaryCellStates() -> [LabelState] {
        let helpCellState = LabelState(text: "SETTINGS_HELP".localized(), imageName: "", imageBgColor: #colorLiteral(red: 0.2941176471, green: 0.6231607199, blue: 0.9967945218, alpha: 1))
        let friendCellState = LabelState(text: "SETTINGS_FRIEND".localized(), imageName: "", imageBgColor: #colorLiteral(red: 0.9991746545, green: 0.1697836518, blue: 0.3347602487, alpha: 1))
        return [helpCellState, friendCellState]
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
    
    private func didSelectTranslationLanguage() {
        let languagesController = LanguagesTableViewController()
        languagesController.didUpdateLanguageDelegate = self
        languagesController.getTableData(languages: languages)
        navigationController?.pushViewController(languagesController, animated: true)
        
    }
    
    func didUpdateLanguage() {
        render()
    }
    
    private func render() {
        let primaryCellStyle = CellStyle(bottomSeparator: .inset, separatorColor: .gray, highlight: false, accessoryType: .disclosureIndicator, selectionColor: #colorLiteral(red: 0.2941176471, green: 0.2980392157, blue: 0.3019607843, alpha: 1), backgroundColor: .black, backgroundView: nil, tintColor: nil, layoutMargins: nil, cornerRadius: 0)
        
        var secondaryCellStyle = primaryCellStyle
        secondaryCellStyle.accessoryType = .none
        
        let primaryRows: [CellConfigType] = getPrimaryCellStates().enumerated().map { index, state in
            return LabelCell(
                key: "id-\(index)",
                style: primaryCellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.didSelectTranslationLanguage()
                        return .deselected
                },
                    deselectionAction: { _ in
                        return .deselected
                }),
                state: state,
                cellUpdater: LabelState.updateView)
        }
        
        let secondaryRows: [CellConfigType] = getSecondaryCellStates().enumerated().map { index, state in
            return LabelCell(
                key: "id-\(index)",
                style: secondaryCellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.didSelectTranslationLanguage()
                        return .deselected
                },
                    deselectionAction: { _ in
                        return .deselected
                }),
                state: state,
                cellUpdater: LabelState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: primaryRows), TableSection(key: "section2", rows: secondaryRows)])
    }
}
