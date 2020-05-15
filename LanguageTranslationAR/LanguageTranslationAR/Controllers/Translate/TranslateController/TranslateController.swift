//
//  TranslateController.swift
//  LanguageTranslationAR
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
        preferences.drawing.backgroundColor = UIColor.tooltip ?? UIColor()
        preferences.drawing.arrowPosition = .bottom
        preferences.drawing.cornerRadius = 15        
        let tipView = EasyTipView(text: "TOOL_TIP_ADD_BUTTON".localized, preferences: preferences)
        return tipView
    }()
    
    var hasShownAPIKeyErrorMessageBefore = false
    
    // MARK: - ARKit
    let augmentedRealitySession = ARSession()
    var configuration = ARWorldTrackingConfiguration()
    let updateQueue = DispatchQueue(label: "queue")
    var focusSquare = FocusSquare()
    var canDisplayFocusSquare = true
    var updatePredictionLabelTimer: Timer?
    
    // MARK: - Vision
    var visionRequests = [VNRequest]()
    var mlPrediction: String?
        
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
        stopARSession()
    }
                
    // MARK: - Event handling
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.didTouchSceneView(touches: touches, event: event)
    }
        
    @objc func updatePredictionLabel() {
        if let mlPrediction = mlPrediction {
            translateOriginalText(text: mlPrediction) { translatedPrediction in
                if let translatedPrediction = translatedPrediction {
                    DispatchQueue.main.async {
                        self.recognizedObjectFeedbackView.textLabel.text = translatedPrediction
                    }
                }
            }
        } else {
            recognizedObjectFeedbackView.textLabel.text = "WARNING_NOTHING_FOUND".localized
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.plusButton.alpha = self.mlPrediction == nil ? 0.5 : 1
            }
        }
    }
    
    func updateUI(planesDetected: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.plusButton.isHidden = !planesDetected
                self.recognizedObjectFeedbackView.isHidden = !planesDetected
                self.clearButtonView.isHidden = !planesDetected
                self.tipView.isHidden = !planesDetected
                self.moveDeviceToScanView.isHidden = planesDetected
            }
        }
    }
    
    func presentDetailView(node: SCNNode, translation: Translation) {
        // Convert the node's position to screen coordinates
        let screenCoordinate = self.sceneView.projectPoint(node.position)
        let xPosition = CGFloat(screenCoordinate.x)
        let yPosition = CGFloat(screenCoordinate.y)
        
        let detailView = ARDetailView(frame: CGRect(x: xPosition, y: yPosition, width: 100, height: 40))
        detailView.delegate = self
        detailView.node = node
        detailView.translation = translation
        view.addSubview(detailView)
        detailView.show()
        self.sceneView.alpha = 0.3
    }
    
    func presentTipView() {
        tipView.show(forView: plusButton, withinSuperview: view)
    }
    
    private func presentWelcomeController() {
        let welcomeController = WelcomeController()
        
        // Prevent user from dismissing view controller in iOS 13
        if #available(iOS 13.0, *) {
            welcomeController.isModalInPresentation = true
        }
        
        let navController = UINavigationController(rootViewController: welcomeController)
        navController.modalPresentationStyle = .formSheet
        
        present(navController, animated: true, completion: nil)
    }
    
    // MARK: - Helper functions
            
    @objc internal func isCameraPermissionGranted() -> Bool {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        return !(cameraAuthorizationStatus == .authorized)
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
 }
