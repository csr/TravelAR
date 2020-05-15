//
//  HistoryController+TableView.swift
//  LanguageTranslationAR
//

import UIKit
import FunctionalTableData

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
                                  selectionColor: UIColor.selectedCell,
                                  backgroundColor: .black)
                
        let rows: [CellConfigType] = getSourceArray().enumerated().map { index, item in
            let deleteAction = CellActions.SwipeActionsConfiguration.ContextualAction(title: "Delete", backgroundColor: UIColor.red, style: .destructive) { _, completion in
                self.didTapDeleteOnItem(item: item)
                completion(true) // The true signifies a successful deletion
            }
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
                },
                    trailingActionConfiguration: CellActions.SwipeActionsConfiguration(actions: [deleteAction])
                ),
                state: HistoryState(translationItem: item),
                cellUpdater: HistoryState.updateView)
        }

        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
        ])
    }
    
    private func didTapDeleteOnItem(item: Translation) {
        TranslationItems.shared.remove(object: item)
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }

    
    private func getSourceArray() -> [Translation] {
        return TranslationItems.shared.getAll()
    }
    
    func someItemDeleted() {
        render()
    }
    
    func newItemAdded() {
        render()
    }
}
