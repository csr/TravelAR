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
        let dictionaryController = DictionaryController()
        dictionaryController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let historyNavController = UINavigationController(rootViewController: HistoryController())
        historyNavController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "history"), tag: 1)
        
        let settingsNavController = UINavigationController(rootViewController: SettingsController())
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "history"), tag: 2)
        
        let tabBarList = [dictionaryController, historyNavController, settingsNavController]
        viewControllers = tabBarList
        
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
    }
}
