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
    // Check out https://wetalkit.xyz/text-recognition-using-vision-and-core-ml-73d8c1d3e239
    
    /// Trained CoreMLModel - detects images, not as effecient as VGG16
    static let resnet50 = Resnet50()
    
}
