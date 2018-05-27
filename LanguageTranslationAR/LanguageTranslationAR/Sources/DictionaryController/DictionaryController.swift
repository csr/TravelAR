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
public class DictionaryController: TopController, PopUpDelegate {

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
            self.topView.selectedLanguage = newValue
        }
    }
    
    var visionRequests = [VNRequest]()
    var mlPrediction: String?
    
    var identifier: String? {
        didSet {
            if identifier == oldValue {
                return
            }
            topView.identifierLabel.alpha = mlPrediction != nil ? 1 : 0.5
            topView.identifierLabel.text = mlPrediction != nil ? mlPrediction : NSLocalizedString("Nothing found", comment: "Nothing found")
            animateImageWalkthrough(shouldBeHidden: mlPrediction == nil)
            if mlPrediction != nil {
                playWavSound(soundName: SoundNames.pop.rawValue)
                imageViewWalkthrough.boingAnimation()
            } else {
                playWavSound(soundName: SoundNames.popReverse.rawValue)
            }
            topView.identifierLabel.pushTransition(0.3)
        }
    }
    
	lazy var sceneView: ARSCNView = {
		let sv = ARSCNView()
		sv.delegate = self
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
    
    let imageViewWalkthrough: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "draw-sign")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
        
	let centerButton: UIButton = {
		let button = UIButton(type: .contactAdd)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.isUserInteractionEnabled = false
		button.tintColor = .white
        button.isHidden = true
		return button
	}()
	
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
        
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.isUserInteractionEnabled = true
        return pv
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView()
        view.delegate = self
        return view
    }()
	
    let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let title = NSLocalizedString("Clear", comment: "Clear")
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.setTitleColor(UIColor.red, for: .normal)
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "CircularStd-Book", size: 19)
        button.alpha = 0.9
        button.titleLabel?.font = font
        button.isHidden = true
        return button
    }()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkCameraPermissions()
    }
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        setupTapGestureRecognizer()
		imageViewWalkthrough.boingAnimation(shouldRepeat: false)
        topView.selectedLanguage = selectedLanguage
	}
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }    
}
