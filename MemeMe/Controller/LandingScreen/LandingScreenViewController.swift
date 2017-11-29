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
    @IBOutlet weak var landingScreenCaptionTopLabel: UILabel!
    @IBOutlet weak var landingScreenCaptionBottomLabel: UILabel!
    
    let memeEditorVCSegue = "memeEditorSegue"
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        meme = Meme.init(originalImage: nil, memeImage: nil, topCaption: nil, bottomCaption: nil)
    }
    
    @IBAction func launchGallery(_ sender: Any)
    {
        let imageSourceType: UIImagePickerControllerSourceType = .photoLibrary
        handleImageSelection(imageSourceType: imageSourceType)
    }
    
    @IBAction func launchCamera(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
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

