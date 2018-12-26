//
//  SettingsView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 26/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

public class SettingsView: UIView {
    
    let bgImageView: NeverClearView = {
        let view = NeverClearView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "translate")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        return label
    }()
    
    let detailTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Test"
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupView()
    }
    
    private func setupImageView() {
        bgImageView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        bgImageView.addSubview(imageView)
        bgImageView.backgroundColor = .white
        
        imageView.centerXAnchor.constraint(equalTo: bgImageView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: bgImageView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: bgImageView.widthAnchor, multiplier: 0.6).isActive = true
        imageView.heightAnchor.constraint(equalTo: bgImageView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupView() {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.fillToSuperview()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.addArrangedSubview(bgImageView)
        stackView.addArrangedSubview(getLabelsStackView())
    }
    
    private func getLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(textLabel)
        textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stackView.addArrangedSubview(detailTextLabel)
        return stackView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
