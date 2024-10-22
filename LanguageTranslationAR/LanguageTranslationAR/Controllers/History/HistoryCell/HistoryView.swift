//
//  HistoryView.swift
//  LanguageTranslationAR
//

import UIKit
import Flags

public class HistoryView: UIView {
    
    var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .primary
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        return textLabel
    }()
    
    var detailTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return textLabel
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var imageViewWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.fillToSuperview()
        stackView.spacing = 20
        
        imageViewWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: 40) //.isActive = true
        imageViewWidthAnchor?.isActive = true
        
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
        
        let textLabelStackView = UIStackView()
        textLabelStackView.addArrangedSubview(textLabel)
        
        topStackView.addArrangedSubview(textLabelStackView)
        let audioImageView = UIImageView()
        audioImageView.translatesAutoresizingMaskIntoConstraints = false
        audioImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        audioImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        audioImageView.image = UIImage.sound
        topStackView.addArrangedSubview(audioImageView)
        topStackView.spacing = 5
        topStackView.distribution = .equalSpacing
        topStackView.alignment = .center
        return topStackView
    }
    
    func setFlag(for countryCode: String?) {
        guard let countryCode = countryCode?.uppercased(), let flag = Flag(countryCode: countryCode) else {
            imageViewWidthAnchor?.constant = 0
            return
        }
        imageViewWidthAnchor?.constant = 40
        imageView.image = flag.image(size: CGSize(width: 50, height: 50), color: .clear)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Flag {
    func image(size: CGSize, color: UIColor = UIColor.white) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        emoji.draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: size.height)])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
