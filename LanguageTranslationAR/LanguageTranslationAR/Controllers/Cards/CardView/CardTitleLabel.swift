//
//  CardTitleLabel.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/30/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CardTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        textAlignment = .center
        numberOfLines = 0
        text = "Hello"
        font = UIFont(name: "Charter-Roman", size: 35)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
