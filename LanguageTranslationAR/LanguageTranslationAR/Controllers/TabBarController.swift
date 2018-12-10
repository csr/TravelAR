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
        let vc = [DictionaryController(), HistoryController(), SettingsController()]

        let navControllers = ApplicationTab.allCases.enumerated().map { (index, tab) -> UINavigationController in
            let viewController = vc[index]
            viewController.title = tab.title
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem = tab.tabBarItem
            return navController
        }
        
        viewControllers = navControllers
        
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
    }
}
