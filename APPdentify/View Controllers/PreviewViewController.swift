//
//  PreviewViewController.swift
//  APPdentify
//
//  Created by Michael Castillo on 2/2/18.
//  Copyright © 2018 Michael Castillo. All rights reserved.
//

import AVFoundation
import UIKit
import Vision

class ViewController: UIViewController {
    
    private var textObservations = [VNTextObservation]()
    private var textDetectionRequest: VNDetectTextRectanglesRequest?
    private let session = AVCaptureSession()
    private var preview: PreviewView {
        return view as! PreviewView
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAuthorized() {
            configureTextDetection()
            configureCamera()
        }
    }
    
    // MARK: - Fileprivate
    private func configureTextDetection() {
        textDetectionRequest = VNDetectTextRectanglesRequest(completionHandler: handleDetection)
        textDetectionRequest!.reportCharacterBoxes = true
    }
    private func configureCamera() {
        preview.session = session
        let cameraDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        var cameraDevice: AVCaptureDevice?
        for device in cameraDevices.devices {
            if device.position == .back {
                cameraDevice = device
                break
            }
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: cameraDevice!)
            if session.canAddInput(captureDeviceInput) {
                session.addInput(captureDeviceInput)
            }
        }
        catch {
            print("Error occured \(error)")
            return
        }
        session.sessionPreset = .high
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "Buffer Queue", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil))
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
        preview.videoPreviewLayer.videoGravity = .resize
        session.startRunning()
    }
    private func handleDetection(request: VNRequest, error: Error?) {
        guard let detectionResults = request.results else {
            print("No detection results")
            return
        }
        let textResults = detectionResults.map() {
            return $0 as? VNTextObservation
        }
        if textResults.isEmpty {
            return
        }
        DispatchQueue.main.async {
            self.view.layer.sublayers?.removeSubrange(1...)
            let viewWidth = self.view.frame.size.width
            let viewHeight = self.view.frame.size.height
            for textObservation in self.textObservations {
                guard let rects = textObservation.characterBoxes else {
                    return
                }
                var xMin = CGFloat.greatestFiniteMagnitude
                var xMax: CGFloat = 0
                var yMin = CGFloat.greatestFiniteMagnitude
                var yMax: CGFloat = 0
                for rect in rects {
                    xMin = min(xMin, rect.bottomLeft.x)
                    xMax = max(xMax, rect.bottomRight.x)
                    yMin = min(yMin, rect.bottomRight.y)
                    yMax = max(yMax, rect.topRight.y)
                }
                let x = xMin * viewWidth
                let y = (1 - yMax) * viewHeight
                let width = (xMax - xMin) * viewWidth
                let height = (yMax - yMin) * viewHeight
                
                let layer = CALayer()
                layer.frame = CGRect(x: x, y: y, width: width, height: height)
                layer.borderWidth = 2
                layer.borderColor = UIColor.red.cgColor
                self.view.layer.addSublayer(layer)
            }
        }
    }

    private func isAuthorized() -> Bool {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted:Bool) -> Void in
                if granted {
                    DispatchQueue.main.async {
                        self.configureCamera()
                        self.configureTextDetection()
                        
                    }
                }
            })
            return true
        case .authorized:
            return true
        case .denied, .restricted: return false
        }
    }

}


// MARK: - Camera Delegate/Setup

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        var imageRequestOptions = [VNImageOption: Any]()
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
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
    }
    
}
