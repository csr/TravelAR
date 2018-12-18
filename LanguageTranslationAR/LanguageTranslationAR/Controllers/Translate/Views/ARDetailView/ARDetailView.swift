//
//  ARDetailView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/18/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class ARDetailView: UIView, NibView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
//        translatesAutoresizingMaskIntoConstraints = false
//        heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}
