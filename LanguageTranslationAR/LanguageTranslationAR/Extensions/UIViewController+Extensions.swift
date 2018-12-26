//
//  UIViewController+Extensions.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 26/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension UIViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar || false
    }
}
