//
//  TabBarController.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 07/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        viewControllers = getViewControllers()
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
    }
    
    private func getViewControllers() -> [UIViewController] {
        let vc = [TranslateController(), HistoryController(), SettingsController()]
        
        let navControllers = ApplicationTab.allCases.enumerated().map { (index, tab) -> UIViewController in
            let viewController = vc[index]
            viewController.title = tab.title
            
            if tab == .translate {
                viewController.tabBarItem = tab.tabBarItem
                return viewController
            }
            
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem = tab.tabBarItem
            return navController
        }
        return navControllers
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
