//
//  ImageController.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/15/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import CoreML
import Vision
// Vision is used hand in hand with CoreML. See #line 27, 30, 34. 

struct ImageController {
    
    static let shared = ImageController()
    fileprivate let modelFile = TrainedModels.resnet50

    func processImage(_ image: UIImage, completion: @escaping (([ImagePrediction], Error?) -> Void)) {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePathURL = documentsPath.appendingPathComponent("image.jpg")
        do {
            try UIImageJPEGRepresentation(image, 0.0)?.write(to: imagePathURL)
            
            // Create Vision Container for our CoreMLModel
            let model = try VNCoreMLModel(for: modelFile.model)
            
            // The VNImageRequestHandler takes care of processing an image
            let handler = VNImageRequestHandler(url: imagePathURL)
            
            // VNCoreMLRequest - Please read documentation on this.
            // It is a powerful inferring method that dynamically changes based on what we pass in
            let request = VNCoreMLRequest(model: model, completionHandler: { request, error in
                guard let results = request.results as? [VNClassificationObservation] else {
                    completion([], error)
                    return
                }
                var predictions = results.map(ImagePrediction.init)
                predictions.sort(by: { $0.accuracy > $1.accuracy })
                completion(predictions, error)
            })
            try handler.perform([request])
        } catch {
            completion([], error)
        }
    }
    
}
