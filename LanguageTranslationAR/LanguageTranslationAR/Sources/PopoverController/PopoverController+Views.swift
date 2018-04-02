//
//  PopoverController+Views.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension PopoverController {
    internal func setupViews() {
        setupTableView()
        setupEmptyStateLabel()
    }
    
    private func setupEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        emptyStateLabel.font = UIFont(name: "CircularStd-Book", size: 20)
        emptyStateLabel.sizeToFit()
    }
    
    private func setupTableView() {
        tableView.register(PopoverTableViewCell.self, forCellReuseIdentifier: PopoverTableViewCell.identifier)
        tableView.tableFooterView = UIView()
    }
}
