 //
//  File.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import Vision
import ARKit
import EasyTipView
 
public class TranslateController: UIViewController {

    // MARK: - Views
    
    // ARKit scene view that displays the camera frames and scene nodes
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        return sceneView
    }()
    
    // Helper views
    lazy var recognizedObjectFeedbackView = CurrentDetectionView()
    lazy var moveDeviceToScanView = ScanningStateView()
    lazy var customARView = CustomARView()
    lazy var plusButton = AddButtonView()
    lazy var clearButtonView = ClearButtonView()
    
    // Added on top of plus button to prompt the user to tap the button
    lazy var tipView: EasyTipView = {
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont.boldSystemFont(ofSize: 19)
        preferences.drawing.backgroundColor = #colorLiteral(red: 0.1411563158, green: 0.1411880553, blue: 0.1411542892, alpha: 1)
        preferences.drawing.arrowPosition = .bottom
        preferences.drawing.cornerRadius = 15        
        let tipView = EasyTipView(text: "TOOL_TIP_ADD_BUTTON".localized, preferences: preferences)
        return tipView
    }()
    
    var screenCenter: CGPoint {
        let bounds = self.sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - ARKit
    let augmentedRealitySession = ARSession()
    var configuration = ARWorldTrackingConfiguration()
    var focusSquare = FocusSquare()
    var canDisplayFocusSquare = true
    
    // MARK: - Vision
    let updateQueue = DispatchQueue(label: "queue")
    var visionRequests = [VNRequest]()
    var mlPrediction: String?
    var previousObjectPrediction = ""
    
    var shouldPresentARDetailView = true {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.sceneView.alpha = self.shouldPresentARDetailView ? 1 : 0.3
            }
        }
    }
    
    // MARK: - View Lifecycle
    
    public override func viewDidLoad() {
		super.viewDidLoad()
        setupViews()        
	}
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isCameraPermissionGranted() {
            presentWelcomeController()
        } else {
            runARSession()
            setupCoreML()
            moveDeviceToScanView.animateImageView()
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - Helper functions
    
    private func presentWelcomeController() {
        let welcomeController = WelcomeController()
        welcomeController.onboardingDelegate = self
        
        // Prevent user from dismissing view controller in iOS 13
        if #available(iOS 13.0, *) {
            welcomeController.isModalInPresentation = true
        }
        
        let navController = UINavigationController(rootViewController: welcomeController)
        navController.modalPresentationStyle = .formSheet
        
        present(navController, animated: true, completion: nil)
    }
            
    @objc internal func isCameraPermissionGranted() -> Bool {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        return !(cameraAuthorizationStatus == .authorized)
    }
    
    // MARK: - Event handling
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.didTouchSceneView(touches: touches, event: event)
    }
 }
