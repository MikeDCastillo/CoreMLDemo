//
//  App.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/5/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

enum App {
    static let sharedCore = Core(state: AppState())
}


struct AppState: State {
    
    var currentImage: UIImage?
    var currentPredictions = [ImagePrediction]()
    var error: Error?
    
    mutating func react(to event: Event) {
        switch event {
        case let event as ImageSelected:
            currentImage = event.image
        case let event as ImageProcessed:
            currentPredictions = event.predictions
            error = event.error
            if error != nil {
                currentPredictions = []
            }
        default:
            break
        }
    }
    
}

struct ImageSelected: Event {
    var image: UIImage?
}

struct ImageProcessed: Event {
    var predictions: [ImagePrediction]
    var error: Error?
}
