//
//  ActionButton.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 19/06/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    let customBgView: UIView = {
        let view = UIView()
        view.alpha = 0.8
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        setupCustomBackgroundView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customBgView.isUserInteractionEnabled = false
        customBgView.layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomBackgroundView() {
        addSubview(customBgView)
        customBgView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        customBgView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        customBgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        customBgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        if let imageView = imageView {
            bringSubviewToFront(imageView)
        }
    }
}
