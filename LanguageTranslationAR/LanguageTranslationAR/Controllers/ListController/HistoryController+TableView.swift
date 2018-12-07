//
//  PopoverController+TableView.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension HistoryController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        emptyStateLabel.isHidden = list.count > 0
        if list.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        TextToSpeech.speak(item: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        let item = list[indexPath.row]
        cell.item = item
        return cell
    }
}
