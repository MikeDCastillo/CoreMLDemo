//
//  Preview.swift
//  APPdentify
//
//  Created by Michael Castillo on 2/1/18.
//  Copyright © 2018 Michael Castillo. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected AVCaptureVideoPreviewLayer type for layer. Check PreviewView.layerClass")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get {
            return videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }
    
    // MARK: UIView
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
}
