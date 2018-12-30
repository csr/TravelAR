//
//  CardView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var dictionaryEntry: (String, String)? {
        didSet {
            guard let entry = dictionaryEntry else { return }
            textLabel.text = entry.0
            secondaryTextLabel.text = entry.1
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Hello"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let secondaryTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Hello"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.fillToSuperview(constant: 15)
        stackView.distribution = .equalCentering
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.addArrangedSubview(textLabel)
        labelsStackView.addArrangedSubview(secondaryTextLabel)
        labelsStackView.spacing = 5
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(UIView())

    }
}
