//
//  TextProcessorViewController.swift
//  APPdentify
//
//  Created by Michael Castillo on 2/6/18.
//  Copyright © 2018 Michael Castillo. All rights reserved.
//

import AVFoundation
import UIKit
import Vision

class TextProcessorViewController: UIViewController {


    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var processButton: UIButton!
    @IBOutlet weak var processedTextView: UITextView!
    
    // Properties
    fileprivate let imagePickerManager = ImagePickerManager()
    private var textDetectionRequest: VNDetectTextRectanglesRequest?
    fileprivate let core = App.sharedCore
    fileprivate var predictedText: String {
        guard let processedText = core.state.processedText else { return "\(#line, #file)" }
        return processedText
    }
    // TODO: - move this into State
    fileprivate var textObservations = [VNTextObservation]()
    //*****************************
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        core.add(subscriber: self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        core.remove(subscriber: self)
    }

    // MARK: - Fileprivate
    fileprivate func detectTextInImage(request: VNRequest, error: Error?, sampleBuffer: CMSampleBuffer) {
        
        guard let detectionResults = request.results else {print("Nothing Detected"); return}
        let textResults = detectionResults.map() {
            return $0 as? VNTextObservation
        }
        if textResults.isEmpty {
            print(#line); return
        }
        textObservations = textResults as! [VNTextObservation]
    
        /////// line 145
    
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        var imageRequestOptions = [VNImageOption: Any]()
        if let cameraData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
            imageRequestOptions[.cameraIntrinsics] = cameraData
        }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 6)!, options: imageRequestOptions)
        do {
            try imageRequestHandler.perform([textDetectionRequest!])
        }
        catch {
            print("Error occured \(error)")
        }
        var ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let transform = ciImage.orientationTransform(for: CGImagePropertyOrientation(rawValue: 6)!)
        ciImage = ciImage.transformed(by: transform)
        let size = ciImage.extent.size
        var recognizedTextPositionTuples = [(rect: CGRect, text: String)]()
    }

    
    @IBAction func cameraViewPressed(_ sender: Any) {
        imagePickerManager.presentPickerAlert(on: self)
    }
    
    @IBAction func processedButtonTapped(_ sender: Any) {
        
//        func performTesseractImageRecognition(withTextIn image: UIImage){
//            if let tesseract = G8Tesseract(language: "eng") {
//                tesseract.engineMode = .tesseractCubeCombined
//                tesseract.pageSegmentationMode = .auto
//                tesseract.image = image.g8_blackAndWhite()
//                tesseract.recognize()
//                processedTextView.text = tesseract.recognizedText
//            }
//                    // TODO: - put activity indicator here
//        }
//    }
    }
}

// MARK: - Subscriber Protocol Adoption

extension TextProcessorViewController: Subscriber {
    
    func update(with state: AppState) {
        processedTextView.text = state.processedText
        
    }
}
