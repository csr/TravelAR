//
//  PopUpView.swift
//  MirrorProject
//
//  Created by Cesare de Cal on 3/27/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVFoundation

@available(iOS 11.0, *)
class PopUpView: UIView {
    
    let viewHeight: CGFloat = 400
    
    var parent: DictionaryController?
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    
    var shouldShowImageWalkthrough: Bool = false {
        didSet {
            imageWalkthroughView.alpha = shouldShowImageWalkthrough ? 1 : 0
        }
    }
    
    var completionHandler: Selector?
    var delegate: PopUpDelegate?
    
    
    private let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topBarView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageWalkthroughView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "draw-sign")
        imageView.alpha = 0
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 22)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 23)
        label.numberOfLines = 0
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 25
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadowView()
        setupView()
        setupTopBar()
        setupStackView()
        confirmButton.addTarget(self, action: #selector(buttonTapHandler), for: .touchUpInside)
        setupDrawSignImageView()
    }
    
    private func setupShadowView() {
        addSubview(shadowView)
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.layer.cornerRadius = 15
        shadowView.layer.masksToBounds = true
        shadowView.backgroundColor = .white
    }
    
    private func setupDrawSignImageView() {
        imageView.addSubview(imageWalkthroughView)
        imageWalkthroughView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        imageWalkthroughView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -26).isActive = true
        imageWalkthroughView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageWalkthroughView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.imageWalkthroughView.boingAnimation(shouldRepeat: true)
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(imageView)
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.addArrangedSubview(confirmButton)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 22).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    func present(title: String, subtitle: String, buttonAction: String, imageName: String, completionHandler: Selector) {
        shouldShow()
        self.completionHandler = completionHandler
        titleLabel.text = title
        descriptionLabel.text = subtitle
        setConfirmButtonText(text: buttonAction)
        imageView.image = UIImage(named: imageName)
        heightConstraint?.constant = imageName.isEmpty ? viewHeight / 1.4 : viewHeight
    }
    
    private func setupView() {
        heightConstraint = heightAnchor.constraint(equalToConstant: viewHeight)
        heightConstraint?.isActive = true
        widthConstraint = widthAnchor.constraint(equalToConstant: viewHeight)
        widthConstraint?.isActive = true
        layer.shadowOpacity = 0.2 // opacity, 20%
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2 // HALF of blur
        layer.shadowOffset = CGSize(width: 0, height: 2) // Spread x, y
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConfirmButtonText(text: String) {
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont(name: "CircularStd-Book", size: 21)!,
                                                         NSAttributedStringKey.foregroundColor: UIColor.white]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        confirmButton.setAttributedTitle(attrString, for: .normal)
    }
    
    private func setupTopBar() {
        shadowView.addSubview(topBarView)
        topBarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBarView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topBarView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        topBarView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor).isActive = true
    }
    
    @objc private func buttonTapHandler() {
        SystemSoundID.playFileNamed(fileName: "button-click-garageband", withExtenstion: "wav")
        shouldHide()
        guard let selector = completionHandler else { return }
        delegate?.didTapButton(selector: selector)
    }
    
    func shouldShow() {
        parent?.popUpCenterYAnchor?.constant = -1000
        layoutIfNeeded()
        
        alpha = 1
        transform = CGAffineTransform(scaleX: 0.3, y: 2)
        SystemSoundID.playFileNamed(fileName: "pop_drip", withExtenstion: "wav")
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            self.transform = .identity
            self.alpha = 1
            self.heightConstraint?.constant = 400
            self.widthConstraint?.constant = 370
            self.parent?.popUpCenterYAnchor?.constant = 0
            self.layoutIfNeeded()
        }, completion: nil)
        
        layoutIfNeeded()
    }
    
    func shouldHide() {
        layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            self.heightConstraint?.constant = 0
            self.widthConstraint?.constant = 0
            self.layoutIfNeeded()
            self.alpha = 0
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

