//
//  ARDetailViewDelegate.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 21/12/2018.
//  Copyright © 2018 Cesare de Cal. All rights reserved.
//

import Foundation
import SceneKit.SCNNode

protocol ARDetailViewDelegate {
    func didTapCloseDetailView()
    func didTapListenPronunciation(translation: Translation)
}
