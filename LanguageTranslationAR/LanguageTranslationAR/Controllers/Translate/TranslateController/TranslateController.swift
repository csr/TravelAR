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
import EasyTipView
 
public class TranslateController: UIViewController {

    internal var items: [Translation] = []

    var customView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let feedbackView: CurrentDetectionView = {
        let view = CurrentDetectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        return sceneView
    }()
    
    lazy var tipView: EasyTipView = {
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont.boldSystemFont(ofSize: 19)
        preferences.drawing.backgroundColor = #colorLiteral(red: 0.1411563158, green: 0.1411880553, blue: 0.1411542892, alpha: 1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        preferences.drawing.cornerRadius = 15
        preferences.positioning.textHInset = 12
        preferences.positioning.textVInset = 12
        
        let tipView = EasyTipView(text: "TOOL_TIP_ADD_BUTTON".localized(), preferences: preferences)
        return tipView
    }()
    
    let augmentedRealitySession = ARSession()
    var configuration = ARWorldTrackingConfiguration()
    
    var focusSquare = FocusSquare()
    var canDisplayFocusSquare = true
    let updateQueue = DispatchQueue(label: "cesaredecal")

    //--------------------
    //MARK: - CoreML Vision
    //--------------------

    var visionRequests = [VNRequest]()
    var mlPrediction: String?
    
    var identifier: String = "" {
        didSet {
            if identifier == oldValue {
                return
            }            
        }
    }
    
    var shouldPresentARDetailView = true {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.sceneView.alpha = self.shouldPresentARDetailView ? 1 : 0.5
            }
        }
    }
    
    var shouldShowToolTip = true
    
    lazy var addButton: AddButtonView = {
        let view = AddButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    public override func viewDidLoad() {
		super.viewDidLoad()
        setupViews()
        
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(showToolTip), userInfo: nil, repeats: false)
	}
    
    @objc private func showToolTip() {
        if shouldShowToolTip {
            presentTipView()
            shouldShowToolTip = false
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCameraPermissionGranted() {
            let navController = UINavigationController(rootViewController: WelcomeController())
            present(navController, animated: true, completion: nil)
        } else {
            runARSession()
            setupCoreML()
        }
    }
    
    @objc internal func isCameraPermissionGranted() -> Bool {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        return !(cameraAuthorizationStatus == .authorized)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.didTouchSceneView(touches: touches, event: event)
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
 }
