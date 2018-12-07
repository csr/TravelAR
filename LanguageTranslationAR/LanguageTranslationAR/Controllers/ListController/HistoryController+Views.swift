//
//  PopoverController+Views.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension HistoryController {
    internal func setupViews() {
        setupTableView()
        setupEmptyStateLabel()
    }
    
    private func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.textColor = .white
        emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        emptyStateLabel.font = UIFont(name: "CircularStd-Book", size: 20)
        emptyStateLabel.sizeToFit()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    internal func render() {
//        let rows: [CellConfigType] = items.enumerated().map { index, item in
//            return HistoryTableViewCell(
//                key: "id-\(index)",
//                actions: CellActions(
//                    selectionAction: { _ in
//                        print("\(item) selected")
//                        return .selected
//                },
//                    deselectionAction: { _ in
//                        print("\(item) deselected")
//                        return .deselected
//                }),
//                state: LabelState(text: item),
//                cellUpdater: LabelState.updateView)
//        }
//        
//        functionalData.renderAndDiff([
//            TableSection(key: "section", rows: rows)
//            ])
    }
}
