//
//  ScanningStateView.swift
//  LanguageTranslationAR
//

import UIKit

// View that prompts the user to move the device to scan the surface

class ScanningStateView: UIView {
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "MOVE_DEVICE_INSTRUCTION".localized
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.search
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(instructionLabel)
        imageView.centerToSuperview()
        instructionLabel.centerToSuperview(verticalOffset: 80)
        instructionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func animateImageView() {
        let centerPoint = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: 10, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.duration = 3
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
