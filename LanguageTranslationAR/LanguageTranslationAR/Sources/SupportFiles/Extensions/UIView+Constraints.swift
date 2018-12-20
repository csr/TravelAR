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
            let left = leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: constant)
            let right = rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -constant)
            let top = topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: constant)
            let bottom = bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
