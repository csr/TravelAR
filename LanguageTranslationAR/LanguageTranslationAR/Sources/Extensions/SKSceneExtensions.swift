//
//  SKSceneExtensions.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 19/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import SpriteKit

extension SKScene {
	var center: CGPoint {
		return CGPoint(x: frame.midX, y: frame.midY)
	}
	
	func randomXPosition() -> CGFloat {
		return CGFloat(arc4random_uniform(UInt32(size.width)))
	}
	
	func randomYPosition() -> CGFloat {
		return CGFloat(arc4random_uniform(UInt32(size.height)))
	}
}
