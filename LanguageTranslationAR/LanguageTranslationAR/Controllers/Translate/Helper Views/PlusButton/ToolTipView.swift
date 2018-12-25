//
//  ToolTipView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 22/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class ToolTipView: UIView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textLabel)
        textLabel.fillToSuperview(constant: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
