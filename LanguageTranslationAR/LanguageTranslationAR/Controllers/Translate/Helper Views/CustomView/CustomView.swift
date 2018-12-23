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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override var intrinsicContentSize: CGSize {
        let w = self.textLabel.intrinsicContentSize.width + 40
        let h = self.textLabel.intrinsicContentSize.height + 40
        return CGSize(width: w, height: h)
    }
}
