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

    internal var items: [Translation] = []
    
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
    
    let suggestionView = SuggestionView()
	
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
    
    public override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
        checkCameraPermissions()
	}
 }
