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
    }
    
    private func render() {        
        let cellStyle = CellStyle(bottomSeparator: .inset, separatorColor: .gray, highlight: false, accessoryType: .none, selectionColor: .gray, backgroundColor: .black, backgroundView: nil, tintColor: nil)
        
        let rows: [CellConfigType] = items.enumerated().map { index, item in
            return HistoryTableViewCell(
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

