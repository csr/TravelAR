 //
//  File.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import AVKit
import Vision
import ARKit
import AVFoundation

@available(iOS 11.0, *) 
public class DictionaryController: UIViewController, PopUpDelegate {

    // MARK: - Languages
    var languages = [Language]()
    var items = [Translation]()
    var player: AVAudioPlayer?
    
    var selectedLanguage: Language {
        get {
            let defaults = UserDefaults.standard
            if let code = defaults.string(forKey: "languageCode"), let name = defaults.string(forKey: "languageName") {
                return Language(name: name, languageCode: code)
            } else {
                return Language(name: "Spanish", languageCode: "es")
            }
        }
        
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue.name, forKey: "languageName")
            defaults.set(newValue.languageCode, forKey: "languageCode")
        }
    }
    
    let languagesTableViewController = LanguagesTableViewController()
    
    var visionRequests = [VNRequest]()
    var mlPrediction: String?
    
    var identifier: String? {
        didSet {
            if identifier == oldValue {
                return
            }
            suggestionView.suggestion = mlPrediction ?? ""
            
            if mlPrediction != nil {
                playWavSound(soundName: SoundNames.pop.rawValue)
            } else {
                playWavSound(soundName: SoundNames.popReverse.rawValue)
            }
        }
    }
    
	lazy var sceneView: ARSCNView = {
		let sv = ARSCNView()
		sv.delegate = self
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
    
	let centerButton: UIButton = {
		let button = UIButton(type: .contactAdd)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isUserInteractionEnabled = false
		button.tintColor = .white
        button.isHidden = true
		return button
	}()
    
    let suggestionView = SuggestionView()
	
	let cameraOverlayView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = #colorLiteral(red: 0.2769357264, green: 0.7137418389, blue: 0.9510393739, alpha: 0.2)
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.borderWidth = 3
		imageView.layer.borderColor = UIColor.white.cgColor
		imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
		return imageView
	}()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView()
        view.delegate = self
        return view
    }()
	        
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        setupTapGestureRecognizer()
        checkCameraPermissions()
	}
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration, options: [])
    }
}

 
extension DictionaryController: LanguageSelectionDelegate {
    func didSelectLanguage(language: Language) {
        
    }
}
