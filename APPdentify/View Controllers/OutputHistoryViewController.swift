//
//  OutputHistoryViewController.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/7/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

class OutputHistoryViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var recognizedTextLabel: UITextView!
    
    // Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
    }
    
}


// MARK: - Fileprivate

extension OutputHistoryViewController {
    
    fileprivate func setupLabels() {
        locationLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 2.0)))
        dateLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 2)))
    }
    
}
