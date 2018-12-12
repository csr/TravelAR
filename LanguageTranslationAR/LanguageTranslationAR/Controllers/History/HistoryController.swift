//
//  HistoryController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 07/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData

class HistoryController: UITableViewController, ItemsDelegate {
    
    internal let functionalData = FunctionalTableData()
    
    internal var items: [Translation] = [] {
        didSet {
            render()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        items = TranslationItems.shared.array
        setupView()
        setupNavigationBar()
        TranslationItems.shared.delegate = self
    }
        
    private func setupView() {
        view.backgroundColor = .black
        functionalData.tableView = tableView
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString("History", comment: "History")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    @objc func didTapAddButton() {
        let translation = Translation(originalText: "backpack", targetLanguage: "es", translatedText: "mochila", sourceLanguage: "en")
        items.append(translation)
        let selection = UISelectionFeedbackGenerator()
        selection.selectionChanged()
    }
    
    private func render() {        
        let cellStyle = CellStyle(bottomSeparator: .inset, separatorColor: .gray, backgroundColor: .black)
        let rows: [CellConfigType] = items.enumerated().map { index, item in
            return HistoryCell(
                key: item.key,
                style: cellStyle,
                actions: CellActions(rowActions: [UITableViewRowAction(style: .destructive, title: "Delete", handler: ({ (rowAction, indexPath) in
                    self.items.remove(at: indexPath.row)
                }))]),
                state: HistoryState(translationItem: item),
                cellUpdater: HistoryState.updateView)
        }
        
        functionalData.renderAndDiff([
            TableSection(key: "section", rows: rows)
            ])
    }
    
    func newItemAdded() {
        items = TranslationItems.shared.array
    }
}

