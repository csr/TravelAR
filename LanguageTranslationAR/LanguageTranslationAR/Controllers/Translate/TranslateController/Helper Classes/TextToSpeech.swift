//
//  TextToSpeech.swift
//  LanguageTranslationAR
//

import UIKit
import AVFoundation

public class TextToSpeech {
    class func speak(item: Translation) {
        let utterance = AVSpeechUtterance(string: item.translatedText)
        utterance.voice = AVSpeechSynthesisVoice(language: item.targetLanguage)
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()        
        DispatchQueue.global(qos: .background).async {
            synthesizer.speak(utterance)
        }
    }
}
