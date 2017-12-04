//
//  ImageOutput.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/9/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import CoreLocation

struct ImageOutput {
    
    // FIXME: - Take out optionals after presentation
    
    var accuracy: Double
    let date: Date?
    let id: String?
    let image: UIImage
    var location: CLLocation?
    let recognizedText: String?
    var title: String
    
    init(accuracy: Double, date: Date, image: UIImage, latitude: Double, longtitude: Double, recognizedText: String, title: String) {
        self.accuracy = accuracy
        self.date = date
        self.id = UUID().uuidString
        self.location = CLLocation(latitude: latitude, longitude: longtitude)
        self.image = image
        self.title = title
        self.recognizedText = recognizedText
    }
    
}
