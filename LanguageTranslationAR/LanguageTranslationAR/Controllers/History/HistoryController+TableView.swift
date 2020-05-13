//
//  HistoryController+TableView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 25/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData
import TBEmptyDataSet

extension HistoryController {
    @objc func didTapAddButton() {
        let translation = Translation(originalText: "backpack", targetLanguage: "es", translatedText: "test", sourceLanguage: "en")
        TranslationItems.shared.add(object: translation)
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
    }
        
    private func didSelectCell(translation: Translation) {
        TextToSpeech.speak(item: translation)
        
        // Deselect row
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndexPath, animated: true)
            
            // Fixes bug in UIKit which causes separator line to hide for a second
            // After deselection
            self.tableView.separatorStyle = .none
            self.tableView.separatorStyle = .singleLine
        }
    }
    
    func render() {
        let cellStyle = CellStyle(bottomSeparator: .inset,
                                  separatorColor: .gray,
                                  highlight: true,
                                  selectionColor: UIColor(named: "selectedCell"),
                                  backgroundColor: .black)
        
        
        
        let rows: [CellConfigType] = getSourceArray().enumerated().map { index, item in
            return HistoryCell(
                key: "index-\(index)-\(item.translatedText)",
                style: cellStyle,
                actions: CellActions(
                    selectionAction: { _ in
                        self.didSelectCell(translation: item)
                        return .selected
                },
                    deselectionAction: { _ in
                        return .deselected
                }),
                state: HistoryState(translationItem: item),
                cellUpdater: HistoryState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
        ])
    }
    
    private func getSourceArray() -> [Translation] {
        if isFiltering {
            return filteredItems
        } else {
            return TranslationItems.shared.getAll()
        }
    }
    
    func someItemDeleted() {
        render()
    }
    
    func newItemAdded() {
        render()
    }
}

extension HistoryController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: "EMPTY_STATE_TITLE".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedString
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: "EMPTY_STATE_DESCRIPTION".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return attributedString
    }
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return #imageLiteral(resourceName: "empty-state-view")
    }
    
    func verticalOffsetForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        return -100
    }
}
