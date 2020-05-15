//
//  TranslateController+ARDetailViewDelegate.swift
//  LanguageTranslationAR
//

import UIKit

extension TranslateController: ARDetailViewDelegate {
    func didTapListenPronunciation(translation: Translation) {
        TextToSpeech.speak(item: translation)
    }
    
    func didTapCloseDetailView() {
        UIView.animate(withDuration: 0.2) {
            self.sceneView.alpha = 1
        }
    }
}
