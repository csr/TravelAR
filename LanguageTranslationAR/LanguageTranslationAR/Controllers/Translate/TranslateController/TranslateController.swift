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

 public class TranslateController: UIViewController {

    internal var items: [Translation] = []

    var customView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let feedbackView: FeedbackView = {
        let view = FeedbackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //--------------------
    //MARK: - AR Variables
    //--------------------
    
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        return sceneView
    }()
    
    let augmentedRealitySession = ARSession()
    var configuration = ARWorldTrackingConfiguration()
    
    var focusSquare = FocusSquare()
    var canDisplayFocusSquare = true
    var screenCenter: CGPoint {
        let bounds = self.sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
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
    
    var shouldPresentARDetailView = true
    
    lazy var addButton: AddButtonView = {
        let view = AddButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    public override func viewDidLoad() {
		super.viewDidLoad()
        setupViews()
	}

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        guard let touch = touches.first else { return }
        let position = touch.location(in: sceneView)
        
        guard let _ = sceneView.hitTest(position, options: nil).first else {
            return
        }
        
        let view = ARDetailView(frame: CGRect(x: position.x, y: position.y, width: 100, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(view)
        UIView.animate(withDuration: 0.2) {
            view.centerXAnchor.constraint(equalTo: self.sceneView.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: self.sceneView.centerYAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: 350).isActive = true
            view.heightAnchor.constraint(equalToConstant: 190).isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
 }
