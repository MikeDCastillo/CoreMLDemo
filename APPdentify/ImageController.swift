//
//  ImageController.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/15/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import CoreML
import UIKit
import Vision
// We import Vision to help convert the image into buffer format. As of now, CoreML does not support the conversion of an UIImage into CVPixelBuffer

struct ImageController {
    
    static let shared = ImageController()
    
    func convertImageWithVision(with imageUrl: NSURL) {
//    func convertImageWithVision(with path: Bundle, imageUrl: NSURL) {
        // This is for a specfic URL. refactor for more generic code
//        let path = Bundle.main.path(forResource: <#T##String?#>, ofType: <#T##String?#>)
//        let imageURL = NSURL.fileURL(withPath: <#T##String#>)
        
        let modelFile = TrainedModels.resnet50
                // TODO: - Error Handling
        guard let model = try? VNCoreMLModel(for: modelFile.model) else { return }
        let handler = VNImageRequestHandler(url: imageUrl as URL)
       
        // VNCoreMLRequest is done on a different thread
       let request = VNCoreMLRequest(model: model, completionHandler: createResult)
        
                // TODO: - Error Handling
        try? handler.perform([request])
    }
    
    func createResult(with request: VNRequest, error: Error?) {
                // TODO: - Error Handling. fatalError?
        guard let results = request.results as? [VNClassificationObservation] else { return }
        var bestPrediction = ""
        // Confidence = Probability, measured from a 0 to 1 scale
        var bestConfidence: VNConfidence = 0
        
        for classification in results {
            if(classification.confidence > bestConfidence) {
                bestConfidence = classification.confidence
                bestPrediction = classification.identifier
            }
        }
        print("predicted: \(bestPrediction) with confidence of \(bestPrediction) out of 1")
                // TODO: - Add this Code into ViewController
        //          resultLabel.text = bestPrediction
    }
    
    func predictImageWithUIKit(image: UIImage, height: Int, width: Int) {
        let model = TrainedModels.resnet50
                // TODO: - grab height and width from mlModel?
        if let pixelBuffer = image.pixelBuffer(width: width, height: height),
        let prediction = try? model.prediction(image: pixelBuffer) {
            print(prediction.classLabel)
            print(prediction.classLabelProbs)
        }
    }
    
}

