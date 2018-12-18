//
//  FeedbackView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/18/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class FeedbackView: UIVisualEffectView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .dark)
        super.init(effect: blurEffect)
        
        layer.cornerRadius = 14
        self.clipsToBounds = true
        
        contentView.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -13).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 13).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
