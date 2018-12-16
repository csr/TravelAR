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
			CAMediaTimingFunctionName.easeInEaseOut)
		animation.type = CATransitionType.push
		animation.subtype = CATransitionSubtype.fromTop
		animation.duration = duration
		layer.add(animation, forKey: convertFromCATransitionType(CATransitionType.push))
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

extension UIView {
    
    /// Adds a view as a subview and constrains it to the edges
    /// of its new containing view.
    ///
    /// - Parameter view: view to add as subview and constrain
    internal func addEdgeConstrainedSubView(view: UIView) {
        addSubview(view)
        edgeConstrain(subView: view)
    }
    
    /// Constrains a given subview to all 4 sides
    /// of its containing view with a constant of 0.
    ///
    /// - Parameter subView: view to constrain to its container
    internal func edgeConstrain(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Top
            NSLayoutConstraint(item: subView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0),
            // Bottom
            NSLayoutConstraint(item: subView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0),
            // Left
            NSLayoutConstraint(item: subView,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .left,
                               multiplier: 1.0,
                               constant: 0),
            // Right
            NSLayoutConstraint(item: subView,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .right,
                               multiplier: 1.0,
                               constant: 0)
            ])
    }
    
}
