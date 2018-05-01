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
	internal func setupAR() {
		let scene = SCNScene()
		sceneView.scene = scene
		let configuration = ARWorldTrackingConfiguration()
		configuration.planeDetection = [.horizontal]
		sceneView.session.run(configuration)
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
		let node : SCNNode = self.createWordText(title: title, subtitle: subtitle)
		self.sceneView.scene.rootNode.addChildNode(node)
		node.position = coords        
		cameraOverlayView.isHidden = false
	}
        
    internal func createWordText(title: String, subtitle: String?) -> SCNNode {
        let depth: Float = 0.01
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        let mainWord = SCNText(string: title, extrusionDepth: CGFloat(depth))
        let font = UIFont(name: "Futura", size: 0.15)
        mainWord.font = font
        mainWord.alignmentMode = kCAAlignmentCenter
        mainWord.firstMaterial?.diffuse.contents = UIColor.orange
        mainWord.chamferRadius = CGFloat(depth)
        mainWord.firstMaterial?.specular.contents = UIColor.white
        mainWord.firstMaterial?.isDoubleSided = true
        
        let secondaryBubble = SCNText(string: subtitle, extrusionDepth: CGFloat(depth))
        let secondaryFont = UIFont(name: "Futura", size: 0.10)
        secondaryBubble.font = secondaryFont
        secondaryBubble.alignmentMode = kCAAlignmentCenter
        secondaryBubble.firstMaterial?.isDoubleSided = true
        secondaryBubble.chamferRadius = CGFloat(depth)
        secondaryBubble.firstMaterial?.diffuse.contents = UIColor.blue
        secondaryBubble.firstMaterial?.specular.contents = UIColor.white
        let (minBound, maxBound) = mainWord.boundingBox
        let mainWordNode = SCNNode(geometry: mainWord)
        mainWordNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        mainWordNode.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, depth/2)

        let (minBoundSec, maxBoundSec) = secondaryBubble.boundingBox
        let secondaryWordNode = SCNNode(geometry: secondaryBubble)
        secondaryWordNode.pivot = SCNMatrix4MakeTranslation( (maxBoundSec.x - minBoundSec.x)/2, maxBoundSec.y, depth/2)
        secondaryWordNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
        let bubbleNodeParent = SCNNode()
        bubbleNodeParent.addChildNode(mainWordNode)
        bubbleNodeParent.addChildNode(secondaryWordNode)
        bubbleNodeParent.constraints = [billboardConstraint]
        return bubbleNodeParent
    }
}
