//
//  HistoryView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 22/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import Flags

public class HistoryView: UIView {
    
    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .orange
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .gray
        textLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return textLabel
    }()
    
    var detailTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .gray
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return textLabel
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .black
    }
    
    private func setupView() {
//        heightAnchor.constraint(equalToConstant: 77).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//
//        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.fillToSuperview()
        stackView.spacing = 20
        
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(setupLabelsStackView())
    }
    
    private func setupLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        textLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        stackView.addArrangedSubview(getTopLabelsStackView())
        
        stackView.addArrangedSubview(detailTextLabel)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stackView
    }
    
    private func getTopLabelsStackView() -> UIStackView {
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.addArrangedSubview(textLabel)
        let audioImageView = UIImageView()
        audioImageView.translatesAutoresizingMaskIntoConstraints = false
        audioImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        audioImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        audioImageView.image = UIImage(named: "sound")
        topStackView.addArrangedSubview(audioImageView)
        topStackView.spacing = 5
        topStackView.distribution = .equalSpacing
        topStackView.alignment = .center
        return topStackView
    }
    
    func setFlag(for countryCode: String?) {
        guard let countryCode = countryCode?.uppercased(), let flag = Flag(countryCode: countryCode) else { return }
        imageView.image = flag.image(size: CGSize(width: 50, height: 50), color: .clear)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Flag {
    public func image(size: CGSize, color: UIColor = UIColor.white) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        emoji.draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: size.height)])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
