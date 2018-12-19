//
//  UIView+Constraints.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/19/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension UIView {
    public func fillToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant)
            let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
