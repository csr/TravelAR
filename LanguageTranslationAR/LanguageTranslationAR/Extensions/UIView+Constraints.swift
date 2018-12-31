//
//  UIView+Constraints.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

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
    
    public func fillToSuperview(constant: CGFloat = 0, includeNotch: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: constant)
            let right = rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -constant)
            let top = includeNotch ? topAnchor.constraint(equalTo: superview.topAnchor, constant: constant) : topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant)            
            let bottom = bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
    
    public func centerToSuperview(verticalOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            let centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: verticalOffset)
            NSLayoutConstraint.activate([centerX, centerY])
        }
    }
}
