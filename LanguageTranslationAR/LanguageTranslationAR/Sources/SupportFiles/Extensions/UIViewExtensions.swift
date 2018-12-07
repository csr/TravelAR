//
//  Helpers.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit

extension UIView {
    func shake() {
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = 0.08
        anim.repeatCount = 4
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        
        self.layer.add(anim, forKey: "position")
    }
    
	func pinToSuperView(parentView: UIView) {
		self.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
		self.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
		self.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
	}
	
	func pushTransition(_ duration:CFTimeInterval) {
		let animation:CATransition = CATransition()
		animation.timingFunction = CAMediaTimingFunction(name:
			kCAMediaTimingFunctionEaseInEaseOut)
		animation.type = kCATransitionPush
		animation.subtype = kCATransitionFromTop
		animation.duration = duration
		layer.add(animation, forKey: kCATransitionPush)
	}
	
	func boingAnimation(shouldRepeat: Bool = false) {
		self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		UIView.animate(withDuration: 1.0,
					   delay: 0,
					   usingSpringWithDamping: 0.21,
					   initialSpringVelocity: 6.0,
					   options: .allowUserInteraction,
					   animations: { [weak self] in
						self?.transform = .identity
			},
					   completion: { _ in
						
						
						if shouldRepeat {
							DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
								self.boingAnimation(shouldRepeat: shouldRepeat)
							}
						}
						
		} )
	}
    
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
