//
//  BasicButton.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 27/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class BasicButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.orange.withAlphaComponent(0.5) : .orange
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
