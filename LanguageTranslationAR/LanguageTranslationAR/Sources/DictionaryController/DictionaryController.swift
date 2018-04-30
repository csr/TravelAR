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
    
    var selectedLanguage: Language = Languages.spanish {
        didSet {
            topView.selectedLanguage = selectedLanguage
        }
    }
    
    lazy var translationPopoverContent: LanguageController = {
        let vc = LanguageController()
        vc.delegate = self
        return vc
    }()
    
	var timer = Timer()
    var planesDetectionTimer = Timer()
	
	lazy var sceneView: ARSCNView = {
		let sv = ARSCNView()
		sv.delegate = self
        sv.alpha = 0.5
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
    
    let hintHandView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "draw-sign")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    let lookAroundLabel: UILabel = {
        let label = UILabel()
        label.text = "Move the device around to detect planes."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        label.numberOfLines = 0
        let cfURL = Bundle.main.url(forResource: "CircularStd-Book", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        label.font = UIFont(name: "CircularStd-Book", size: 30)
        return label
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView()
        view.delegate = self
        view.parent = self
        return view
    }()
	
    let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear", for: .normal)
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
    
    var popUpCenterYAnchor: NSLayoutConstraint?
    var hintViewCenterXAnchor: NSLayoutConstraint?
    var mlPrediction: String?
    var translationDict = [String: [String: String]]()
    let bookmarksPopoverContent = ListController()
    var visionRequests = [VNRequest]()
    
    public override func viewDidLoad() {
		super.viewDidLoad()
        selectedLanguage = Languages.spanish
		setupViews()
        setupJSONFiles()
        setupCoreML()
		setupTapGestureRecognizer()
		imageViewWalkthrough.boingAnimation(shouldRepeat: false)
        
        fetchJSON(for: "apple", source_lang: "en")
        checkCameraPermissions()
	}
    
    private func checkCameraPermissions() {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            popUpView.present(title: "Ooops!", subtitle: "It looks like we don't have camera permissions.", buttonAction: "Enable camera in settings", imageName: "welcome", completionHandler: #selector(detectingPlanesState))
        case .authorized:
            popUpView.present(title: "Welcome!", subtitle: "To start learning a new language, we'll need camera permissions.", buttonAction: "Turn on camera", imageName: "welcome", completionHandler: #selector(detectingPlanesState))
        case .restricted: break
        case .notDetermined:
            popUpView.present(title: "Welcome!", subtitle: "To start learning a new language, we'll need camera permissions.", buttonAction: "Turn on camera", imageName: "welcome", completionHandler: #selector(detectingPlanesState))
        }
    }
            
    internal func animateImageWalkthrough(shouldBeHidden: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.imageViewWalkthrough.alpha = shouldBeHidden ? 0.2 : 1
        }
    }
	
	func setupTimers() {
        planesDetectionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.detectPlanes), userInfo: nil, repeats: true)
	}
	
    func didTapSceneView(coords: SCNVector3) {
        guard let latestPrediction = mlPrediction else {
            print("latest prediction is nil")
            imageViewWalkthrough.shake()
            topView.identifierLabel.shake()
            return
        }
        
        var item: Item?
        
        if let (key, value) = getDictionaryEntry(language: selectedLanguage, word: latestPrediction) {
            if selectedLanguage == Languages.english {
                item = Item(predictedWord: latestPrediction, englishKey: key, englishDefinition: value, translation: nil, translatedLanguage: selectedLanguage)
            } else {
                if let (englishKey, englishDefinition) = getDictionaryEntry(language: Languages.english, word: latestPrediction) {
                    item = Item(predictedWord: latestPrediction, englishKey: englishKey, englishDefinition: englishDefinition, translation: value, translatedLanguage: selectedLanguage)
                }
            }
        } else {
            item = Item(predictedWord: latestPrediction, englishKey: nil, englishDefinition: nil, translation: nil, translatedLanguage: Languages.english)
        }
        
        if !latestPrediction.isEmpty {
            addNode(title: latestPrediction, subtitle: item?.translation, coords: coords)
        } else {
            imageViewWalkthrough.shake()
            return
        }
        
        if let item = item {
            animateDictionaryView(item: item)
            if !bookmarksPopoverContent.list.contains(item) {
                bookmarksPopoverContent.list.append(item)
                topView.bookmarksButton.boingAnimation()
                clearButton.isHidden = false
                
                if bookmarksPopoverContent.list.count == 1 {
                    setupImageViewHint()
                }
                
            }
            TextToSpeech.speak(item: item)
        }
    }
    
    
    func didTapButton(selector: Selector) {
        SystemSoundID.playFileNamed(fileName: "pop_drip-reverse", withExtenstion: "wav")
        performSelector(onMainThread: selector, with: nil, waitUntilDone: true)
    }
    
    
    internal func planesDetectedState() {
        topView.showRightIcons()
        UIView.animate(withDuration: 0.5) {
            self.sceneView.alpha = 1
            self.lookAroundLabel.alpha = 0
            self.imageViewWalkthrough.alpha = 1
            self.cameraOverlayView.alpha = 1
        }
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
        planesDetectionTimer.invalidate()
        
        popUpView.present(title: "Good job!", subtitle: "Point your device at an object and tap the screen when a suggestion pops up.", buttonAction: "OK, let's try!", imageName: "phone-sketch", completionHandler: #selector(didTapOKTapToAdd))
        popUpView.shouldShowImageWalkthrough = true
    }    
}
