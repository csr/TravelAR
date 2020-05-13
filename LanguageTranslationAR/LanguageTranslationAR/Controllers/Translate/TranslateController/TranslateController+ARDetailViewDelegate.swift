//
//  TranslateController+ARDetailViewDelegate.swift
//  LanguageTranslationAR
//
//  Created by Cesare de Cal on 5/13/20.
//  Copyright © 2020 Cesare de Cal. All rights reserved.
//

import Foundation

extension TranslateController: ARDetailViewDelegate {
    func didTapListenPronunciation(translation: Translation) {
        TextToSpeech.speak(item: translation)
    }
    
    func didTapCloseDetailView() {
        self.shouldPresentARDetailView = true
    }
}
