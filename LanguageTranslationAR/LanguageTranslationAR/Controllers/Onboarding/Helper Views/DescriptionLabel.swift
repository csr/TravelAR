//
//  DescriptionLabel.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 26/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class DescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    private func setupLabel() {
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .white
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
