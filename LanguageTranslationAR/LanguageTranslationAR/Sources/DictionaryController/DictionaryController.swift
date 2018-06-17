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

    //--------------------
    //MARK: - Data
    //--------------------
    
    var items = [Translation]()
    let languagesTableViewController = LanguagesTableViewController()
    
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
    //MARK: - UI
    //--------------------
    
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
    
    //------------------------
    // MARK: - View Life Cycle
    //------------------------
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        setupTapGestureRecognizer()
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
}
