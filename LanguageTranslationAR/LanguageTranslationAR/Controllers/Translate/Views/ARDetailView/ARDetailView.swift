//
//  ARDetailView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/18/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class ARDetailView: UIView, NibView {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        buttonClose.setTitle("MENU_ACTION_CLOSE".localized(), for: .normal)
        labelTitle.text = "TRANSLATION".localized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
