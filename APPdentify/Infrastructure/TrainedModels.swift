//
//  TrainedModelController.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/9/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import CoreML
import UIKit

class TrainedModels {
    
    /// Trained CoreMLModel - detects text
    static let alphanum = Alphanum_28x28()
    
    /// Trained CoreMLModel - detects images, not as effecient as VGG16
    static let resnet50 = Resnet50()
    
}
