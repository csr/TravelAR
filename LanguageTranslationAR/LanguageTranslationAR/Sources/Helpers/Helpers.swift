//
//  Helpers.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 01/05/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import UIKit

func getDeviceName() -> String {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        return "iPad"
    case .phone:
        return "iPhone"
    default:
        return "device"
    }
}
