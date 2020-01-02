//
//  Platform.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 1/2/20.
//  Copyright © 2020 Cesare de Cal. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        #if arch(i386) || arch(x86_64)
            return true
        #endif
        return false
    }()
}
