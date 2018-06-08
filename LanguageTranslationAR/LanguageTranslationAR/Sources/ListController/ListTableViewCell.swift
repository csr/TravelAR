//
//  PopoverTableViewCell.swift
//  testPlayground
//
//  Created by Cesare de Cal on 22/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "PopoverTableViewCell"
    
    var item: Translation? {
        didSet {
            guard let item = item else { return }
            textLabel?.text = item.translatedText
            detailTextLabel?.text = item.originalText
        }
    }
    
    var soundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sound")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let objectImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: ListTableViewCell.identifier)
        setupLabels()
        setupImageView()
        setupObjectImageView()
    }
    
    private func setupObjectImageView() {
        addSubview(objectImageView)
        objectImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        objectImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        objectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        objectImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    }
    
    private func setupLabels() {
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        textLabel?.font = UIFont(name: "CircularStd-Book", size: 25)
        textLabel?.numberOfLines = 0
        detailTextLabel?.font = UIFont(name: "CircularStd-Book", size: 14)
        detailTextLabel?.numberOfLines = 0
    }
    
    private func setupImageView() {
        addSubview(soundImageView)
        if let label = textLabel {
            soundImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
            soundImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
            soundImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 2).isActive = true
            soundImageView.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 3).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
