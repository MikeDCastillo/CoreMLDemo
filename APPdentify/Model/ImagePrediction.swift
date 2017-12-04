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
    
    var accuracy: Double
    let predictedTitle: String
    
    init(observation: VNClassificationObservation) {
        self.init(predictedTitle: observation.identifier, accuracy: Double(observation.confidence.binade))
    }
    
    init(predictedTitle: String, accuracy: Double) {
        self.predictedTitle = predictedTitle
        self.accuracy = accuracy
    }
    
}
