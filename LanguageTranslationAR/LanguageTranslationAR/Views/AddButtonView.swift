//
//  AddButtonView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/13/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 40
        backgroundColor = .white
        setupInnerView()
    }
    
    private func setupInnerView() {
        addSubview(innerView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        //event.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
