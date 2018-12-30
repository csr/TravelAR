//
//  CardView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import RandomColor

class CardView: UIView {
    
    var frontView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let bgColor = randomColor(hue: .orange, luminosity: .dark)
        view.backgroundColor = bgColor
        return view
    }()
    
    var rearView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dictionaryEntry: (String, String)? {
        didSet {
            guard let entry = dictionaryEntry else { return }
            frontTitleLabel.text = entry.0
            secondaryTextLabel.text = entry.1
        }
    }
    
    private let frontTitleLabel: CardTitleLabel = {
        let label = CardTitleLabel()
        label.textColor = .white
        return label
    }()
    
    private let rearTitleLabel: CardTitleLabel = {
        let label = CardTitleLabel()
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
    
    private let instructionTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.text = "Tap to view translation".uppercased()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func applyCornerRadius(to view: UIView) {
        view.layer.cornerRadius = 10.0
    }
    
    private func setupView() {
        applyCornerRadius(to: self)
        addSubview(frontView)
        applyCornerRadius(to: frontView)
        frontView.fillToSuperview()
        setupFrontStackView()
        
        addSubview(rearView)
        applyCornerRadius(to: rearView)
        rearView.fillToSuperview()
    }
    
    private func setupFrontStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        frontView.addSubview(stackView)
        stackView.fillToSuperview(constant: 15)
        stackView.distribution = .equalCentering
        stackView.spacing = 25
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.addArrangedSubview(frontTitleLabel)
        labelsStackView.addArrangedSubview(secondaryTextLabel)
        labelsStackView.spacing = 5
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(UIView())
    }
    
    private func setupRearStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        frontView.addSubview(stackView)
        stackView.fillToSuperview(constant: 15)
        stackView.distribution = .equalCentering
        stackView.spacing = 25
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.addArrangedSubview(frontTitleLabel)
        labelsStackView.addArrangedSubview(secondaryTextLabel)
        labelsStackView.spacing = 5
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(UIView())
    }

    func didTapCard() {
        if rearView.isHidden {
            UIView.transition(with: self, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                self.rearView.isHidden = false
                self.bringSubviewToFront(self.rearView)
            }) { (finished) in
                self.rearView.isHidden = false
            }
        } else {
            UIView.transition(with: self, duration: 0.5, options: [.transitionFlipFromRight], animations: {
                self.bringSubviewToFront(self.frontView)
            }) { (finished) in
                self.rearView.isHidden = true
            }
        }
    }
}
