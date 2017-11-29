//
//  LandingScreenViewController+UIImagePickerControllerDelegate.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 10/25/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension LandingScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func handleImageSelection(imageSourceType: UIImagePickerControllerSourceType)
    {
        let galleryImagePicker = UIImagePickerController()
        galleryImagePicker.delegate = self
        galleryImagePicker.sourceType = imageSourceType
        present(galleryImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        dismiss(animated: true, completion: nil)
        //navigate to meme editor VC when done selecting image
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImageJPEGRepresentation(image, 0.7)
        
        if let imageData = imageData
        {
            meme.originalImage = UIImage(data: imageData)!
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
}
