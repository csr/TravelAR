//
//  CustomView.swift
//  LanguageTranslationAR
//

import UIKit

// View placed on top of objects in the ARKit scene displaying the real world

class CustomARView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let disclosureIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.disclosureIndicator
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStackView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        addSubview(stackView)

        // Top, left, right, bottom constraints
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
        
        // Disclosure Indicator Image View
        disclosureIndicatorImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(disclosureIndicatorImageView)
    }
    
    public func setText(text: String?) {
        textLabel.text = text
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
