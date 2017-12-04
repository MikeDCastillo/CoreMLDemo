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
    fileprivate let requiredSize = 224
    fileprivate let modelFile = TrainedModels.resnet50

    func processImage(_ image: UIImage, completion: @escaping (([ImagePrediction], Error?) -> Void)) {
        // Save Image to local URL
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePathURL = documentsPath.appendingPathComponent("image.jpg")
        do {
            try UIImageJPEGRepresentation(image, 0.0)?.write(to: imagePathURL)
            let model = try VNCoreMLModel(for: modelFile.model)
            let handler = VNImageRequestHandler(url: imagePathURL)
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
