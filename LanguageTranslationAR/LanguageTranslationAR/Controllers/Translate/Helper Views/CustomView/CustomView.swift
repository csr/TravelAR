//
//  CustomView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/17/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CustomView: UIView, NibView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        //translatesAutoresizingMaskIntoConstraints = false
        //heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}
