//
//  TitleLabel.swift
//  LanguageTranslationAR
//

import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    private func setupLabel() {
        font = UIFont.boldSystemFont(ofSize: 33)
        numberOfLines = 0
        textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
