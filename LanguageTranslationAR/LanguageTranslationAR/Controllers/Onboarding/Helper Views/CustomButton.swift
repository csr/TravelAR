//
//  CustomButton.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/14/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CustomButton: BasicButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.orange.withAlphaComponent(0.5) : .orange
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
