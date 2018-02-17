//
//  UIImageHelper.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/16/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import CoreML

extension UIImage {
    
    // This is alternate way to get CVPixelBuffer out of an image, instead of using Vision Wrapper
    
    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let attributes = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        
        /// '&pixelBuffer' refers to address.
        /// the pixelFormatType will be chosen based on the .mlmodel your bring into your file. read carefully. This will not work if you choose incorrectly
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(width), Int(height), kCVPixelFormatType_32RGBA, attributes as CFDictionary, &pixelBuffer)
        guard status == kCVReturnSuccess, let imageBuffer = pixelBuffer
            else { return nil }
        
        /// This saves memory. taking room for memory
        // TODO: - read up on buffer lock flags. we're gonna use the raw value for now of 0
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        // this has to do with the associated address referenced in the constant status '&pixelBuffer'
        let imageData = CVPixelBufferGetBaseAddress(imageBuffer)
        guard let context = CGContext(data: imageData, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(imageBuffer), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            else { return nil }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        // you must pop after push. this balances the push
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height) )
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return imageBuffer
    }
    
    /// Take the H or W of the image (whichever is bigger of the 2) and equal that to our maxDimension parameter. We set the other dimension then, preserving the Aspect ratio. Finally, draw the original image into the new frame.
    func scaleImage(_ maxDimension: CGFloat) -> UIImage? {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        
        if size.width > size.height {
            let scaleFactor = size.height / size.width
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            let scaleFactor = size.width / size.height
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }

    
}

// https://www.hackingwithswift.com/whats-new-in-ios-11

