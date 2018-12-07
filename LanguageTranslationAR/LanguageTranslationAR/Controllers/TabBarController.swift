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
        let secondViewController = ListController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        let tabBarList = [dictionaryController, secondViewController]
        viewControllers = tabBarList
        
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
    }
}
