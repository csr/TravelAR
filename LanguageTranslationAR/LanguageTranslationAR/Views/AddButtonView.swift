//
//  AddButtonView.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/13/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 40
        backgroundColor = .white
        setupInnerView()
    }
    
    private func setupInnerView() {
        addSubview(innerView)
        innerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        innerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        innerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        innerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animateTo(frame: CGRect(origin: self.frame.origin, size: innerView.frame.size), withDuration: 1)
    
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.touchesEnded(touches, with: event)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
