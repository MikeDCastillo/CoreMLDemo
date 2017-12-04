//
//  ImagePickerController.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/1/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit

class ImagePickerManager: NSObject {
    
    static let shared = ImagePickerManager()
    
    
    // MARK: - FilePrivate
    
    fileprivate func presentImagePicker(sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        if sourceType == .camera {
            imagePicker.cameraCaptureMode = .photo
        }
        imagePicker.allowsEditing = true
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
   func presentPickerAlert(on viewController: UIViewController) {
        let alertController = UIAlertController(title: "", message: "Select Source", preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        
        let cameraAction = UIAlertAction(title: "Camera 📷", style: .default) { _ in
            self.presentImagePicker(sourceType: .camera, from: viewController)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library 🌄", style: .default) { _ in
            self.presentImagePicker(sourceType: .photoLibrary, from: viewController)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(photoLibraryAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}


// MARK: - UIImagePickerControllerDelegate

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            try! UIImageJPEGRepresentation(pickedImage, 0.0)?.write(to: imagePath!)
            ImageController.shared.predictImageWithUIKit(image: pickedImage, height: 224, width: 224)
            
            // TODO: -
            //add into app state here
          
            // TODO: - process with Vision if unsuccessful
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

struct ProcessImage: Command {
    
    var image: UIImage
    
    func execute(state: AppState, core: Core<AppState>) {
        //obtaining saving path
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
    }
    
}
