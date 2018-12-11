//
//  PopUpView.swift
//  MirrorProject
//
//  Created by Cesare de Cal on 3/27/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit
import AVFoundation

class PopUpView: UIView {
    
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
        view.backgroundColor = .deepBlue
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
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .deepBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0
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
    
    func present(title: String, subtitle: String, buttonAction: String, imageName: String? = nil, completionHandler: Selector) {
        show()
        self.completionHandler = completionHandler
        titleLabel.text = title
        descriptionLabel.text = subtitle
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            imageView.image = image
            let aspectRatio = image.size.height / image.size.width
            let newHeight: CGFloat = aspectRatio * 330
            imageView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
            layoutIfNeeded()
        }
    }
    
    private func setupView() {
        widthAnchor.constraint(equalToConstant: 330).isActive = true
        layer.shadowOpacity = 0.2 // opacity, 20%
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2 // HALF of blur
        layer.shadowOffset = CGSize(width: 0, height: 2) // Spread x, y
        translatesAutoresizingMaskIntoConstraints = false
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
        hide()
        guard let selector = completionHandler else { return }
        delegate?.didTapButton(selector: selector)
    }
    
    func show() {
        alpha = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [UIView.AnimationOptions.allowUserInteraction], animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: [UIView.AnimationOptions.allowUserInteraction], animations: {
            self.alpha = 0
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

