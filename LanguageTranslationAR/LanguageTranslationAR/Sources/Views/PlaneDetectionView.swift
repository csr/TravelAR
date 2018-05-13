//
//  PlaneDetectionView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 13/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class PlaneDetectionView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIDevice.current.userInterfaceIdiom == .pad ? #imageLiteral(resourceName: "ipad-icon") : #imageLiteral(resourceName: "iphone-icon")
        return imageView
    }()
    
    let lookAroundLabel: UILabel = {
        let label = UILabel()
        let format = NSLocalizedString("Move device", comment: "Move device to scan environment")
        label.text = String.localizedStringWithFormat(format, getDeviceName())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        label.numberOfLines = 0
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        deviceImageView.blink()
        lookAroundLabel.blink()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        stackView.addArrangedSubview(deviceImageView)
        stackView.addArrangedSubview(lookAroundLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
