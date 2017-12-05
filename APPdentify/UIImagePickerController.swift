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
    var core = App.sharedCore
    
    
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
    // Creates a UIAlertController which we call in our ViewController to show the user and have them select a camera or library media choice.
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
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        // These hit our ImageController functions to process the Image picked, once the user has chosen an image
        // The core handles firing events and commands which eventually make it back the state to update the AppState
        core.fire(event: ImageSelected(image: selectedImage))
        core.fire(command: ProcessImage(selectedImage))
        picker.dismiss(animated: true, completion: nil)
    }
    
}
