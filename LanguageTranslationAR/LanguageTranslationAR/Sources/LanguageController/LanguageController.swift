//
//  LanguageController.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

class LanguageController: BasePopUpController {
    
    var delegate: LanguageSelectionDelegate?
    var languages = [Language]()
    
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupLanguages()
        setupGestureRecognizer()
        title = "Translation Language"
        loadLanguages()
    }
    
    private func loadLanguages() {
        GoogleTranslateAPI.getLanguages(target_language: "en") { (languages) in
            self.languages = languages
            self.pickerView.reloadAllComponents()
        }
    }
    
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickerTapped(tapRecognizer:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        pickerView.addGestureRecognizer(tap)
    }
    
    @objc func pickerTapped(tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let rowHeight = self.pickerView.rowSize(forComponent: 0).height
            let selectedRowFrame = self.pickerView.bounds.insetBy(dx: 0, dy: (self.pickerView.frame.height - rowHeight) / 2)
            let userTappedOnSelectedRow = selectedRowFrame.contains(tapRecognizer.location(in: self.pickerView))
            if userTappedOnSelectedRow {
                let selectedRow = self.pickerView.selectedRow(inComponent: 0)
                pickerView(self.pickerView, didSelectRow: selectedRow, inComponent: 0)
            }
        }

        print("tapped picker!")
        handleTapOnDone()
    }
            
    private func setupLanguages() {
        //languages = Languages.getAll()
        pickerView.reloadAllComponents()
    }
    
    private func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension LanguageController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
