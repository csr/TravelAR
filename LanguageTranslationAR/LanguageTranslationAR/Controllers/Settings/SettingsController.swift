//
//  SettingsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

class SettingsController: UITableViewController, DidUpdateLanguageDelegate {
    
    private let functionalData = FunctionalTableData()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        functionalData.tableView = tableView
        render()
        didUpdateLanguage()
        setupView()
    }
        
    func setupView() {
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        tableView.tableFooterView = UIView()
    }
    
    // Primary cell states include the "Translate To" row
    private func getPrimaryCellStates() -> [SettingsState] {
        let currentLanguage = LanguagePreferences.getCurrent()
        let translateCellState = SettingsState(text: "SETTINGS_TRANSLATE_TO".localized, detailText: currentLanguage.name, imageName: "translate", imageBgColor: .red, selector: #selector(didSelectTranslationLanguage))
        return [translateCellState]
    }
    
    // Secondary cell states include the Help, Feedback sections
    private func getSecondaryCellStates() -> [SettingsState] {
        let helpCellState = SettingsState(text: "SETTINGS_HELP".localized, imageName: "help", imageBgColor: #colorLiteral(red: 0.2941176471, green: 0.6231607199, blue: 0.9967945218, alpha: 1), selector: #selector(didTapHelpRow))
        let friendCellState = SettingsState(text: "SETTINGS_GITHUB".localized, imageName: "heart", imageBgColor: #colorLiteral(red: 0.9991746545, green: 0.1697836518, blue: 0.3347602487, alpha: 1), selector: #selector(didTapViewOnGitHubRow))
        return [helpCellState, friendCellState]
    }
    
    @objc private func didSelectTranslationLanguage() {
        let languagesController = LanguagesController()
        languagesController.didUpdateLanguageDelegate = self
        navigationController?.pushViewController(languagesController, animated: true)
    }
    
    @objc internal func didTapHelpRow() {
        let alertPrompt = UIAlertController(title: nil, message: "SETTINGS_HELP_DESCRIPTION".localized, preferredStyle: .actionSheet)
        
        if let popoverController = alertPrompt.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        let mailAction = UIAlertAction(title: "E_MAIL".localized, style: .default) { (action) in
            self.composeSupportEmail()
        }
        
        let telegramAction = UIAlertAction(title: "Telegram", style: .default) { (action) in
            self.launchApp(decodedURL: "tg://resolve?domain=cesare_d")
        }

        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil)
        
        alertPrompt.addAction(mailAction)
        alertPrompt.addAction(telegramAction)
        alertPrompt.addAction(cancelAction)
        
        present(alertPrompt, animated: true, completion: nil)
    }
    
    func launchApp(decodedURL: String) {
        if let url = URL(string: decodedURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
        
    @objc private func didTapViewOnGitHubRow() {
        guard let url = URL(string: "https://github.com/csr/TravelAR") else {
          return
        }

        UIApplication.shared.open(url)
    }
    
    private func deselectRow() {
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    func didUpdateLanguage() {
        render()
    }
    
    private func render() {
        let primaryCellStyle = CellStyle(bottomSeparator: .inset,
                                         separatorColor: .gray,
                                         highlight: true,
                                         accessoryType: .disclosureIndicator,
                                         selectionColor: UIColor.selectedCell,
                                         backgroundColor: .black)
        
        var secondaryCellStyle = primaryCellStyle
        secondaryCellStyle.accessoryType = .none
        
        let primaryRows: [CellConfigType] = getPrimaryCellStates().enumerated().map { index, state in
            return LabelCell(
                key: "id-\(index)",
                style: primaryCellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.deselectRow()
                        self.perform(state.selector, with: nil)
                        return .selected
                },
                    deselectionAction: { _ in
                        return .deselected
                }),
                state: state,
                cellUpdater: SettingsState.updateView)
        }
        
        let secondaryRows: [CellConfigType] = getSecondaryCellStates().enumerated().map { index, state in
            return LabelCell(
                key: "id-\(index)",
                style: secondaryCellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.deselectRow()
                        self.perform(state.selector, with: nil)
                        return .selected
                },
                    deselectionAction: { _ in
                        return .deselected
                }),
                state: state,
                cellUpdater: SettingsState.updateView)
        }
        
        var headerCellStyle = primaryCellStyle
        headerCellStyle.bottomSeparator = .none
        
        let headerRows: [CellConfigType] = [HeaderCell(key: "key", style: secondaryCellStyle, state: HeaderState(height: 50), cellUpdater: HeaderState.updateView)]
        
        functionalData.renderAndDiff([TableSection(key: "sectionH", rows: headerRows),
            TableSection(key: "section", rows: primaryRows), TableSection(key: "sectionH2", rows: headerRows), TableSection(key: "section2", rows: secondaryRows)])
    }
}
