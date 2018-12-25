//
//  AppDelegate.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 02/04/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        window = UIWindow()
        window?.tintColor = .orange
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarController()
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

