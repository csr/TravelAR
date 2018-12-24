//
//  CardView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Hello"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
    
    private func setupTextLabel() {
        addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
