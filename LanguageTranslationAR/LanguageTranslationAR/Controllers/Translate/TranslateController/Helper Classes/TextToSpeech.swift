import UIKit
import AVFoundation

public class TextToSpeech {
    class func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "EN")
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    class func speak(item: Translation) {
        let utterance = AVSpeechUtterance(string: item.translatedText)
        utterance.voice = AVSpeechSynthesisVoice(language: item.targetLanguage)
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
