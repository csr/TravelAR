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
			convertToCAMediaTimingFunctionName(convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeInEaseOut)))
		animation.type = convertToCATransitionType(convertFromCATransitionType(CATransitionType.push))
		animation.subtype = convertToOptionalCATransitionSubtype(convertFromCATransitionSubtype(CATransitionSubtype.fromTop))
		animation.duration = duration
		layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.push))
	}
	
	func boingAnimation(shouldRepeat: Bool = false) {
		self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		UIView.animate(withDuration: 1.0,
					   delay: 0,
					   usingSpringWithDamping: 0.21,
					   initialSpringVelocity: 6.0,
					   options: UIView.AnimationOptions.allowUserInteraction,
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
        UIView.animate(withDuration: 1, delay: 0.0, options: [UIView.AnimationOptions.curveLinear, UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
	return CAMediaTimingFunctionName(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionSubtype(_ input: CATransitionSubtype) -> String {
	return input.rawValue
}
