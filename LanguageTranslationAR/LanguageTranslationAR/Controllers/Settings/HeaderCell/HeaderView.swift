//
//  HeaderView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 25/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

public class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
