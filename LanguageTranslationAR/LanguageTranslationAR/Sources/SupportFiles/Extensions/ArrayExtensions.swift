//
//  ArrayExtensions.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 19/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import Foundation

extension Array {
	/// Pick a random element from the array
	func random() -> Element {
		return self[Int(arc4random_uniform(UInt32(count)))]
	}
}
