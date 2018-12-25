//
//  HistoryController+Views.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 25/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension HistoryController {
    func setupViews() {
        setupView()
        setupNavigationBar()
        setupSearchController()
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        self.navigationItem.searchController = search
    }
    
    private func setupView() {
        view.backgroundColor = .black
        functionalData.tableView = tableView
        
        tableView.emptyDataSetDataSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
}
