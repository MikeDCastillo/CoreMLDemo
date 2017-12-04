//
//  Commands.swift
//  APPdentify
//
//  Created by Michael Castillo on 12/4/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

struct ProcessImage: Command {
    
    var image: UIImage
    fileprivate let imageController = ImageController()
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    func execute(state: AppState, core: Core<AppState>) {
        imageController.processImage(image) { predictions, error in
            core.fire(event: ImageProcessed(predictions: predictions, error: error))
        }
    }
    
}
