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
    
	var timer = Timer()
    var planesDetectionTimer = Timer()
	
	lazy var sceneView: ARSCNView = {
		let sv = ARSCNView()
		sv.delegate = self
        sv.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
        imageView.isHidden = true
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
        let format = NSLocalizedString("Move device", comment: "Move device to scan environment")
        label.text = String.localizedStringWithFormat(format, getDeviceName())
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
        view.parent = self
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
    
    var popUpCenterYAnchor: NSLayoutConstraint?
    var hintViewCenterXAnchor: NSLayoutConstraint?
    var mlPrediction: String?
    var translationDict = [String: [String: String]]()
    let bookmarksPopoverContent = ListController()
    var visionRequests = [VNRequest]()
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        setupCoreML()
		setupTapGestureRecognizer()
		imageViewWalkthrough.boingAnimation(shouldRepeat: false)
        topView.selectedLanguage = selectedLanguage
	}
    
    private func checkCameraPermissions() {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            let title = NSLocalizedString("Camera permissions", comment: "Camera permissions")
            let buttonActionTitle = NSLocalizedString("Enable camera", comment: "Enable camera settings")
            popUpView.present(title: "Ooops!", subtitle: title, buttonAction: buttonActionTitle, imageName: "welcome", completionHandler: #selector(detectingPlanesState))
        case .authorized:
                detectingPlanesState()
        case .restricted:
            break
        case .notDetermined:
            let title = NSLocalizedString("Welcome", comment: "Welcome")
            let subtitle = NSLocalizedString("Ask camera permission", comment: "Ask camera permission")
            let buttonActionTitle = NSLocalizedString("Turn on camera", comment: "Turn on camera")
            popUpView.present(title: title, subtitle: subtitle, buttonAction: buttonActionTitle, imageName: "welcome", completionHandler: #selector(openCameraSettings))
        }
    }
    
    @objc func openCameraSettings() {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
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
            imageViewWalkthrough.shake()
            topView.identifierLabel.shake()
            return
        }
        
        if !latestPrediction.isEmpty {
            getTranslations(text: latestPrediction) { (translations) in
                DispatchQueue.main.async {
                    if let firstTranslation = translations.first {
                        self.addNode(title: latestPrediction, subtitle: firstTranslation.translatedText, coords: coords)
                        self.handleIncomingTranslation(translation: firstTranslation)
                    }
                }
            }
        } else {
            imageViewWalkthrough.shake()
            return
        }
    }
    
    func handleIncomingTranslation(translation: Translation) {
        self.animateDictionaryView(item: translation)
        TextToSpeech.speak(item: translation)
        
        if !self.bookmarksPopoverContent.list.contains(translation) {
            self.bookmarksPopoverContent.list.append(translation)
            self.topView.bookmarksButton.boingAnimation()
            self.clearButton.isHidden = false
            
            if self.bookmarksPopoverContent.list.count == 1 {
                self.setupImageViewHint()
            }
        }
    }
    
    func didTapButton(selector: Selector) {
        SystemSoundID.playFileNamed(fileName: "pop_drip-reverse", withExtenstion: "wav")
        performSelector(onMainThread: selector, with: nil, waitUntilDone: true)
    }
    
    
    internal func planesDetectedState() {
        topView.showRightIcons()
        sceneView.debugOptions = []
        UIView.animate(withDuration: 0.5) {
            self.sceneView.alpha = 1
            self.lookAroundLabel.alpha = 0
            self.imageViewWalkthrough.alpha = 1
            self.cameraOverlayView.alpha = 1
        }
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
        planesDetectionTimer.invalidate()
        
        let title = NSLocalizedString("Good job", comment: "Good job")
        let format = NSLocalizedString("Point device", comment: "Point device at object")
        let subtitle = String.localizedStringWithFormat(format, getDeviceName())
        let buttonTitle = NSLocalizedString("Let's try", comment: "OK, let's try!")
        
        popUpView.present(title: title, subtitle: subtitle, buttonAction: buttonTitle, imageName: "phone-sketch", completionHandler: #selector(didTapOKTapToAdd))
        popUpView.shouldShowImageWalkthrough = true
    }    
}

public enum PreferenceType: String {
    
    case about = "General&path=About"
    case accessibility = "General&path=ACCESSIBILITY"
    case airplaneMode = "AIRPLANE_MODE"
    case autolock = "General&path=AUTOLOCK"
    case cellularUsage = "General&path=USAGE/CELLULAR_USAGE"
    case brightness = "Brightness"
    case bluetooth = "Bluetooth"
    case dateAndTime = "General&path=DATE_AND_TIME"
    case facetime = "FACETIME"
    case general = "General"
    case keyboard = "General&path=Keyboard"
    case castle = "CASTLE"
    case storageAndBackup = "CASTLE&path=STORAGE_AND_BACKUP"
    case international = "General&path=INTERNATIONAL"
    case locationServices = "LOCATION_SERVICES"
    case accountSettings = "ACCOUNT_SETTINGS"
    case music = "MUSIC"
    case equalizer = "MUSIC&path=EQ"
    case volumeLimit = "MUSIC&path=VolumeLimit"
    case network = "General&path=Network"
    case nikePlusIPod = "NIKE_PLUS_IPOD"
    case notes = "NOTES"
    case notificationsId = "NOTIFICATIONS_ID"
    case phone = "Phone"
    case photos = "Photos"
    case managedConfigurationList = "General&path=ManagedConfigurationList"
    case reset = "General&path=Reset"
    case ringtone = "Sounds&path=Ringtone"
    case safari = "Safari"
    case assistant = "General&path=Assistant"
    case sounds = "Sounds"
    case softwareUpdateLink = "General&path=SOFTWARE_UPDATE_LINK"
    case store = "STORE"
    case twitter = "TWITTER"
    case facebook = "FACEBOOK"
    case usage = "General&path=USAGE"
    case video = "VIDEO"
    case vpn = "General&path=Network/VPN"
    case wallpaper = "Wallpaper"
    case wifi = "WIFI"
    case tethering = "INTERNET_TETHERING"
    case blocked = "Phone&path=Blocked"
    case doNotDisturb = "DO_NOT_DISTURB"
    
}
