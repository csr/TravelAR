//
//  ScanningStateView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 31/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class ScanningStateView: UIView {
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Move iPhone to start"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "search")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(instructionLabel)
        imageView.centerToSuperview(verticalOffset: -50)
        instructionLabel.centerToSuperview(verticalOffset: 70)
    }
    
    func animateImageView() {
        let centerPoint = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: 15, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath

        imageView.layer.add(animation, forKey: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animateImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
