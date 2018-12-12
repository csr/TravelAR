//
//  SettingsController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import FunctionalTableData
import Eureka

class SettingsController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        setupForm()
    }
    
    private func setupForm() {
        form +++
            Section()
        <<< PushRow<String>() {
            $0.title = "Translate to"
            $0.options = ["Spanish", "Italian", "Norwegian", "English"]
            $0.value = "Spanish"
            $0.selectorTitle = "Translate to"
            $0.cell.backgroundColor = .black
            }
            .onPresent { from, to in
                to.selectableRowSetup = { row in
                    row.cellProvider = CellProvider<ListCheckCell<String>>(nibName: "SettingsCell", bundle: Bundle.main)
                }
                to.selectableRowCellUpdate = { cell, row in
                    var detailText: String?
//                    switch row.selectableValue {
//                    case 💁🏻, 👦🏼: detailText = "Person"
//                    case 🐗, 🐼, 🐻: detailText = "Animal"
//                    case 🍐: detailText = "Food"
//                    default: detailText = ""
//                    }
                    cell.detailTextLabel?.text = detailText
                }
            }.cellUpdate({ (cell, row) in
                cell.textLabel?.textColor = .white
                cell.backgroundColor = .black
                //https://github.com/xmartlabs/Eureka/issues/537
                //implement your own 
            })
    }
}

class SettingsCell: ListCheckCell<String> {}
