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
    
    // These properties are related to the output of our Neural Network
    // Because I am using Resnet50 (which is a small .mlmodel file), my results can come back innacurately.
    //These properties will reflect that when I call them in my view
    var accuracy: Double
    let predictedTitle: String
    
    
    // Two different initializers I use for different parts in my app
    init(observation: VNClassificationObservation) {
        //the observation here is a classification produced my image analysis
        self.init(predictedTitle: observation.identifier, accuracy: Double(observation.confidence.binade))
    }
    
    init(predictedTitle: String, accuracy: Double) {
        self.predictedTitle = predictedTitle
        self.accuracy = accuracy
    }
    
}
