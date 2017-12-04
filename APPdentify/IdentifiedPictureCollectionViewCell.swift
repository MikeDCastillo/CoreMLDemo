//
//  IdentifiedObjectCollectionViewCell.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/9/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

protocol Nameable {  }

extension Nameable {
    static var className: String {
        return String(describing: Self.self)
    }
}

class ImageOutputCollectionViewCell: UICollectionViewCell, Nameable {
 
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOutputImageView: UIImageView!
    
    func update(with imageOutput: ImageOutput) {
        // TODO: - add extension to Location and Date for string interpolation
//        dateLabel.text = imageOutput.date
//        locationLabel.text = imageOutput.location
        titleLabel.text = imageOutput.title
        imageOutputImageView.image = imageOutput.image
        
    }
  
}
