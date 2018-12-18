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
public class DictionaryController: UIViewController {

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
    
    var identifier: String? {
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
        setupAR()
        setupCoreML()
        setupViews()
	}
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldPresentWelcomeController() {
            present(WelcomeController(), animated: true, completion: nil)
        }
    }
    
    @objc internal func shouldPresentWelcomeController() -> Bool {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .denied:
            return true
        case .authorized:
            return false
        case .restricted:
            return true
        case .notDetermined:
            return true
        }
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
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
 }
