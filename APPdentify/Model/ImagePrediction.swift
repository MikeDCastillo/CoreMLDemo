//
//  ImageOutput.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/9/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import Vision

struct ImagePrediction {
    
    let predictedTitle: String // One prediction of the neural network's interpretation of the image
    var accuracy: Double // The accuracy of 👆
    
    
    init(observation: VNClassificationObservation) {
        // The observation here is a classification produced by the image analysis
        self.init(predictedTitle: observation.identifier, accuracy: Double(observation.confidence.binade))
    }
    
    init(predictedTitle: String, accuracy: Double) {
        self.predictedTitle = predictedTitle
        self.accuracy = accuracy
    }
    
}
