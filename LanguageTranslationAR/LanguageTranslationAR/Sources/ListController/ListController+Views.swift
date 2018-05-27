//
//  PopoverController+Views.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension ListController {
    internal func setupViews() {
        setupTableView()
        setupEmptyStateLabel()
    }
    
    private func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        emptyStateLabel.font = UIFont(name: "CircularStd-Book", size: 20)
        emptyStateLabel.sizeToFit()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
}
