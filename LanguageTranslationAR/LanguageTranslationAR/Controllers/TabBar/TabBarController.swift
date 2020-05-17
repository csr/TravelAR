//
//  TabBarController.swift
//  LanguageTranslationAR
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
        let translateController = createController(from: TranslateController(), tab: .translate)
        let historyController = createController(from: HistoryController(), tab: .history, embedInNavController: true)
        let settingsController = createController(from: SettingsController(), tab: .settings, embedInNavController: true)
        return [translateController, historyController, settingsController]
    }
    
    private func createController(from viewController: UIViewController, tab: ApplicationTab, embedInNavController: Bool = false) -> UIViewController {
        viewController.title = tab.title
        if embedInNavController {
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem = tab.tabBarItem
            return navController
        } else {
            viewController.tabBarItem = tab.tabBarItem
            return viewController
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
