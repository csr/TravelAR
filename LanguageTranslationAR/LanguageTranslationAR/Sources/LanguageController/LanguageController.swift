//
//  LanguageController.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import AVKit

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        view.backgroundColor = .white
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
    
    private func setupNavigationBar() {
        title = "Translation Language"
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 20)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: font!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleTapOnDone))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func handleTapOnDone() {
        SystemSoundID.playFileNamed(fileName: "button-click-garageband", withExtenstion: "wav")
        dismiss(animated: true, completion: nil)
    }
    
    private func setupLanguages() {
        languages = Languages.getAll()
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
