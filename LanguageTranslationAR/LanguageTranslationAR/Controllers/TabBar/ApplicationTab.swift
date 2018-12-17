//
//  ApplicationTab.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 10/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

enum ApplicationTab: Int, CaseIterable {
    case translate
    case history
    case cards
    case settings
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: title,
                            image: activeImage,
                            tag: tabNumber)
    }
    
    var title: String {
        switch self {
        case .translate: return "TITLE_TAB_TRANSLATE".localized()
        case .history: return "TITLE_TAB_HISTORY".localized()
        case .cards: return "TITLE_TAB_CARDS".localized()
        case .settings: return "TITLE_TAB_SETTINGS".localized()
        }
    }
    
    var activeImage: UIImage {
        var image: UIImage?
        switch self {
        case .translate: image = UIImage(named: "translate")
        case .history: image = UIImage(named: "history")
        case .cards: image = UIImage(named: "history")
        case .settings: image = UIImage(named: "settings")
        }
        return image!
    }
    
    var tabNumber: Int {
        return self.rawValue
    }
}
