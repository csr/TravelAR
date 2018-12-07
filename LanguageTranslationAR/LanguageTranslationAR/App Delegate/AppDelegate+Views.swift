//
//  AppDelegate+Views.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 07/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

extension AppDelegate {
    internal func setupRootViewController() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarController()
    }
    
    internal func setupNavigationAppearance() {
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        UINavigationBar.appearance().barTintColor = .deepBlue
        UINavigationBar.appearance().tintColor = .white
        
        var attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            as [NSAttributedStringKey: Any]
        
        if let font = UIFont(name: "CircularStd-Book", size: 20.5) {
            attributes[NSAttributedStringKey.font] = font
        }
        
        UINavigationBar.appearance().titleTextAttributes = attributes
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
    }
}
