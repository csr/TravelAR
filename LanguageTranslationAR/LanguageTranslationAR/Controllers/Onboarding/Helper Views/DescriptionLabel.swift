//
//  DescriptionLabel.swift
//  LanguageTranslationAR
//

import UIKit

class DescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    private func setupLabel() {
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .white
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
