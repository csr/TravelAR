//
//  ARDetailViewDelegate.swift
//  LanguageTranslationAR
//

import Foundation
import SceneKit.SCNNode

protocol ARDetailViewDelegate {
    func didTapCloseDetailView()
    func didTapListenPronunciation(translation: Translation)
}
