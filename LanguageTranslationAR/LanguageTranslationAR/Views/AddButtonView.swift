//
//  AddButtonView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/13/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.alpha = 0.5
        return view
    }()
    
    let plusButton: UIImageView = {
        let view = UIImageView()
        //view.image = #imageLiteral(resourceName: "add")
        view.isUserInteractionEnabled = true
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
        setupInnerView()
    }
    
    private func setupInnerView() {
        addSubview(backgroundView)
        backgroundView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(plusButton)
        plusButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.plusButton.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            self.plusButton.transform = .identity
        }, completion: { _ in
            let impact = UIImpactFeedbackGenerator()
            impact.impactOccurred()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.layer.cornerRadius = frame.height/2
        plusButton.layer.cornerRadius = frame.height/2
    }
}

extension UIView {
    func animateTo(frame: CGRect, withDuration duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        guard let _ = superview else {
            return
        }
        
        let xScale = frame.size.width / self.frame.size.width
        let yScale = frame.size.height / self.frame.size.height
        let x = frame.origin.x + (self.frame.width * xScale) * self.layer.anchorPoint.x
        let y = frame.origin.y + (self.frame.height * yScale) * self.layer.anchorPoint.y
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.layer.position = CGPoint(x: x, y: y)
            self.transform = self.transform.scaledBy(x: xScale, y: yScale)
        }, completion: completion)
    }
}
