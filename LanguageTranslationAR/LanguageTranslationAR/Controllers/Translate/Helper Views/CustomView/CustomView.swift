//
//  CustomView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/17/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "teclado de computatodraa test"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    let disclosureIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "disclosure-indicator")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStackView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 30
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.fillToSuperview(constant: 15)
        disclosureIndicatorImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(disclosureIndicatorImageView)
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
