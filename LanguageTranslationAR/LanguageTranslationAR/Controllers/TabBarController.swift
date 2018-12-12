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
        guard let settingsController = UIStoryboard(name: "SettingsScreen", bundle: .main).instantiateViewController(withIdentifier: "Settings") as? SettingsController else { return }
        let vc = [DictionaryController(), HistoryController(), settingsController]

        let navControllers = ApplicationTab.allCases.enumerated().map { (index, tab) -> UINavigationController in
            let viewController = vc[index]
            viewController.title = tab.title
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem = tab.tabBarItem
            return navController
        }
        
        viewControllers = navControllers        
        tabBar.barTintColor = .black
    }
}
