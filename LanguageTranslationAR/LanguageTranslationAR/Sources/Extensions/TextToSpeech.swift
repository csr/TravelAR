import UIKit
import AVFoundation
import Foundation

public class TextToSpeech {
    class func speak(item: Translation) {
        let message = item.translatedText
        let languageCode = item.detectedSourceLanguage
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
