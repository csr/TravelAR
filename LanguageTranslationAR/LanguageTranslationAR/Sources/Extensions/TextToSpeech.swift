import UIKit
import AVFoundation
import Foundation

public class TextToSpeech {
    class func speak(item: Item) {
        let message = item.translation ?? item.predictedWord
        let languageCode = item.translatedLanguage?.languageCode
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
