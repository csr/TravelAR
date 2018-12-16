//
//  DictionaryController+ARKit.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import ARKit

@available(iOS 11.0, *)
extension DictionaryController: ARSCNViewDelegate {

    @objc internal func setupAR() {
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.session = augmentedRealitySession        
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//        if (setUp) {
//            return
//        }
//        
//        setUp = true
//        
//        // Create a SceneKit plane to visualize the plane anchor using its position and extent.
//        //        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
//        let plane = SCNPlane(width: 0.03, height: 0.03)
//        let planeNode = SCNNode(geometry: plane)
//        planeNode.simdPosition = float3(planeAnchor.center.x, 0, planeAnchor.center.z)
//        
//        /*
//         `SCNPlane` is vertically oriented in its local coordinate space, so
//         rotate the plane to match the horizontal orientation of `ARPlaneAnchor`.
//         */
//        planeNode.eulerAngles.x = -.pi / 2
//        
//        // Make the plane visualization semitransparent to clearly show real-world placement.
//        //        planeNode.opacity = 0.1
//        
//        plane.firstMaterial?.blendMode = .max
//        plane.firstMaterial?.diffuse.contents = self.contentController?.view
//        print("setting transparency mode")
//        //        plane.firstMaterial?.transparencyMode = SCNTransparencyMode.rgbZero
//        /*
//         Add the plane visualization to the ARKit-managed node so that it tracks
//         changes in the plane anchor as plane estimation continues.
//         */
//        
//        node.addChildNode(planeNode)
    }
    
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async { self.updateFocusSquare() }
    }
    
    func updateFocusSquare() {
        if let camera = self.augmentedRealitySession.currentFrame?.camera,
            case .normal = camera.trackingState,
            let result = self.sceneView.smartHitTest(screenCenter) {
            updateQueue.async {
                if self.canDisplayFocusSquare {
                    self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                    self.focusSquare.state = .detecting(hitTestResult: result, camera: camera)
                }
            }
            
        } else {
            updateQueue.async {
                if self.canDisplayFocusSquare {
                    self.focusSquare.state = .initializing
                    self.sceneView.pointOfView?.addChildNode(self.focusSquare)
                }
            }
        }
    }
    
    internal func detectWorldCoordinates() -> SCNVector3? {
        let screenCentre = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        let arHitTestResults = sceneView.hitTest(screenCentre, types: [.featurePoint])
        if let closestResult = arHitTestResults.first {
            let transform = closestResult.worldTransform
            return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        } else {
            return nil
        }
    }
	
    internal func addNode(title: String, subtitle: String?, coords: SCNVector3) {

	}
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATextLayerAlignmentMode(_ input: CATextLayerAlignmentMode) -> String {
	return input.rawValue
}
