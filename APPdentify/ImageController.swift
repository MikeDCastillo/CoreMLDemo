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
    /// This required size is found by using the metadata from our .mlmodel
    fileprivate let requiredSize = 224
    fileprivate let modelFile = TrainedModels.resnet50

    func processImage(_ image: UIImage, completion: @escaping (([ImagePrediction], Error?) -> Void)) {
        // Save Image to local URL
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePathURL = documentsPath.appendingPathComponent("image.jpg")
        do {
            // We're going to take our image and write it to a path.
            try UIImageJPEGRepresentation(image, 0.0)?.write(to: imagePathURL)
            // Create Vision Container for our CoreMLModel
            let model = try VNCoreMLModel(for: modelFile.model)
            //  Our VNImageRequestHandler will take care of processing any image we pass in. even multiple image  if need be
            let handler = VNImageRequestHandler(url: imagePathURL)
            // VNCoreMLRequest - Please read documentation on this. It is a powerful inferring method that dynamically changes based on what we pass in
            let request = VNCoreMLRequest(model: model, completionHandler: { request, error in
                // handle our results
                guard let results = request.results as? [VNClassificationObservation] else {
                    completion([], error)
                    return
                }
                // Here we call our custom initializer from our Model to initialize our [results]
                var predictions = results.map(ImagePrediction.init)
                // sort our results based on highest accuracy
                predictions.sort(by: { $0.accuracy > $1.accuracy })
                // complete with our results
                completion(predictions, error)
            })
            // perform our request with our completed results
            try handler.perform([request])
        } catch {
            completion([], error)
        }
    }
    
}
