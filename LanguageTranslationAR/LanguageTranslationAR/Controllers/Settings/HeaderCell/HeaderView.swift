//
//  HeaderView.swift
//  LanguageTranslationAR
//

import UIKit

public class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
