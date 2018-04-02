//
//  UIViewControllerExtensions.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import AudioToolbox

extension SystemSoundID {
	static func playFileNamed(fileName: String, withExtenstion fileExtension: String) {
		var sound: SystemSoundID = 0
		if let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
			AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
			AudioServicesPlaySystemSound(sound)
		}
	}
}
