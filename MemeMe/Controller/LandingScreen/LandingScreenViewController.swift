//
//  LandingScreenViewController.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 10/17/17.
//  Copyright © 2017 Omeileo. All rights reserved.

import UIKit
import Foundation

class LandingScreenViewController: UIViewController
{
    @IBOutlet weak var landingScreenCaptionTop: UITextField!
    @IBOutlet weak var landingScreenCaptionBottom: UITextField!
    @IBOutlet weak var memeGalleryButton: UIBarButtonItem!
    @IBOutlet weak var launchCameraButton: UIButton!
    
    let memeEditorVCSegue = "memeEditorSegue"
    var meme: Meme!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeCaptions = [landingScreenCaptionTop, landingScreenCaptionBottom]
        
        for caption in memeCaptions
        {
            configureCaptionText(caption: caption!, fontFamily: FontFamily.helvetica.rawValue)
        }
       
        setupCamera()
        memeGalleryButton.isEnabled = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        meme = Meme.init(originalImage: nil, memeImage: nil, topCaption: nil, bottomCaption: nil)
    }
    
    func setupCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
        }
        else
        {
            launchCameraButton.isHidden = true
        }
    }
    
    @IBAction func launchGallery(_ sender: Any)
    {
        let imageSourceType: UIImagePickerControllerSourceType = .photoLibrary
        handleImageSelection(imageSourceType: imageSourceType)
    }
    
    @IBAction func launchCamera(_ sender: Any)
    {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == memeEditorVCSegue
        {
            let memeEditorVC = segue.destination as! MemeEditorViewController
            meme = sender as? Meme
            memeEditorVC.meme = meme
        }
    }
}

