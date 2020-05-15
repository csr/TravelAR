//
//  ApplicationTab.swift
//  LanguageTranslationAR
//

import UIKit

enum ApplicationTab: Int, CaseIterable {
    case translate
    case history
    case settings
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: title,
                            image: activeImage,
                            tag: tabNumber)
    }
    
    var title: String {
        switch self {
        case .translate: return "TITLE_TAB_TRANSLATE".localized
        case .history: return "TITLE_TAB_HISTORY".localized
        case .settings: return "TITLE_TAB_SETTINGS".localized
        }
    }
    
    var activeImage: UIImage {
        var image: UIImage?
        switch self {
        case .translate:
            image = UIImage.translateTabBar
        case .history:
            image = UIImage.historyTabBar
        case .settings:
            image = UIImage.settingsTabBar
        }
        return image ?? UIImage()
    }
    
    var tabNumber: Int {
        return self.rawValue
    }
}
