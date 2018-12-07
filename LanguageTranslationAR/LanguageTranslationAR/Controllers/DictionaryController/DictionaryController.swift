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

    lazy var items = [Translation]()
    lazy var languagesTableViewController = LanguagesTableViewController()
    
    //--------------------
    //MARK: - AR Variables
    //--------------------
    
    lazy var augmentedRealityView: ARSCNView = {
        let sv = ARSCNView()
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let augmentedRealitySession = ARSession()
    var configuration = ARWorldTrackingConfiguration()
    
    //--------------------------
    //MARK: - Apple Focus Square
    //--------------------------
    
    var focusSquare = FocusSquare()
    var canDisplayFocusSquare = true
    var screenCenter: CGPoint {
        let bounds = self.augmentedRealityView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    let updateQueue = DispatchQueue(label: "cesaredecal")

    //--------------------
    //MARK: - CoreML Vision
    //--------------------

    var visionRequests = [VNRequest]()
    var mlPrediction: String?

    var player: AVAudioPlayer?

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
    
    //--------------------
    //MARK: - Constraints
    //--------------------
    internal var regularConstraints: [NSLayoutConstraint] = []
    internal var compactConstraints: [NSLayoutConstraint] = []
    internal var sharedConstraints: [NSLayoutConstraint] = []
    
    //--------------------
    //MARK: - UI
    //--------------------
    
//    let centerButton: UIButton = {
//        let button = UIButton(type: .contactAdd)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isUserInteractionEnabled = false
//        button.tintColor = .white
//        button.isHidden = true
//        return button
//    }()
    
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
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        return button
    }()
//
//    lazy var languagesButton: ActionButton = {
//        let languagesButton = ActionButton()
//        languagesButton.addTarget(self, action: #selector(handleTapOnLanguageSelection), for: .touchUpInside)
//        languagesButton.setImage(#imageLiteral(resourceName: "translate"), for: .normal)
//        return languagesButton
//    }()
    
    let translationButton: ActionButton = {
        let translationButton = ActionButton()
        translationButton.addTarget(self, action: #selector(handleTapOnBookmarks), for: .touchUpInside)
        translationButton.setImage(#imageLiteral(resourceName: "history"), for: .normal)
        return translationButton
    }()
    
    //------------------------
    // MARK: - View Life Cycle
    //------------------------
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        checkCameraPermissions()
	}
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        augmentedRealityView.session.pause()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        augmentedRealityView.session.run(configuration, options: [])
    }
    
    // More: https://stackoverflow.com/questions/25685829/programmatically-implementing-two-different-layouts-using-size-classes
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if !sharedConstraints[0].isActive {
            NSLayoutConstraint.activate(sharedConstraints)
        }
        
        // iPad
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
        } else {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        }
    }
}
