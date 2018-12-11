
//
//  SuggestionView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 6/7/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class SuggestionView: UIVisualEffectView {
    
    var suggestion: String? {
        didSet {
            if let suggestion = suggestion, !suggestion.isEmpty {
                label.text = suggestion
            }
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Nothing found", comment: "Nothing found")
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .dark)
        super.init(effect: blurEffect)
        translatesAutoresizingMaskIntoConstraints = false
        setupLabel()
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    internal func setupLabel() {
        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
