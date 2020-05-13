//
//  FeedbackView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/18/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

// This view shows the object name currently recognized by the app
// If nothing is found, it will show 'Keep moving'

class CurrentDetectionView: UIVisualEffectView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST_LABEL".localized
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .dark)
        super.init(effect: blurEffect)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 14
        clipsToBounds = true
        contentView.addSubview(textLabel)
        textLabel.fillToSuperview(constant: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
