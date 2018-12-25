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
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        presentBlurredView()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        hideBlurredView()
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
    
    private func presentBlurredView() {
        guard let rootVC = window?.rootViewController as? UITabBarController, let viewController = rootVC.viewControllers?.first else { return }
        print("print view controller:", type(of: viewController))
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewController.view.frame
        blurEffectView.tag = 100
        self.window?.addSubview(blurEffectView)
    }
    
    private func hideBlurredView() {
        self.window?.viewWithTag(100)?.removeFromSuperview()
    }
}

