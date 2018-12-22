//
//  UIView+Extensions.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 12/22/18.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
