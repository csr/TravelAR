//
//  DictionaryController+CoreML.swift
//  WWDC-App
//
//  Created by Cesare de Cal on 16/03/2018.
//  Copyright © 2018 Cesare Gianfilippo Astianatte de Cal. All rights reserved.
//

import UIKit
import Vision

@available(iOS 11.0, *)
extension DictionaryController {
	internal func setupCoreML() {
		guard let mlmodelcFile = Bundle.main.url(forResource: "exampleModelFP16", withExtension: "mlmodelc") else {
			print("error finding model")
			return
		}
        		
		do {
			let selectedModel = try VNCoreMLModel(for: try MLModel(contentsOf: mlmodelcFile))
			let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
			classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop
			visionRequests = [classificationRequest]
			loopCoreMLUpdate()
		} catch let error {
			print(error)
		}
	}
	
	private func loopCoreMLUpdate() {
		DispatchQueue(label: "com.cesare.ml").async {
			self.updateCoreML()
			self.loopCoreMLUpdate()
		}
	}
	
	private func updateCoreML() {
		guard let pixbuff = sceneView.session.currentFrame?.capturedImage else { return }
		let ciImage = CIImage(cvPixelBuffer: pixbuff)
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
		do {
			try imageRequestHandler.perform(self.visionRequests)
		} catch {
			print(error)
		}
	}
	
    private func classificationCompleteHandler(request: VNRequest, error: Error?) {
		if let error = error {
			print("Error: " + (error.localizedDescription))
			return
		}
		guard let obs = request.results else {
			print("No results")
			return
		}
		
		let classifications = obs[0...1] // top 2 results
			.flatMap({
				$0 as? VNClassificationObservation
			}).map({
				if $0.confidence > 0.3 {
					return "\($0.identifier)"
				} else {
					return ""
				}
			})
			.joined(separator: "")
		
		
		DispatchQueue.main.async {
			var name: String = "…"
			name = classifications.components(separatedBy: "-")[0]
			name = name.components(separatedBy: ",")[0]
            if name.isEmpty {
                self.mlPrediction = nil
            } else {
                self.mlPrediction = name
            } 
		}
	}
}
