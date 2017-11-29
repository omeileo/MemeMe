//
//  CameraViewController.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 10/17/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//  Custom camera setup code referenced from: https://github.com/rizwankce/Camera/blob/master/Camera/ViewController.swift

import UIKit
import AVFoundation
import Foundation

class LandingScreenViewController: UIViewController
{
    @IBOutlet weak var landingScreenCaptionTopLabel: UILabel!
    @IBOutlet weak var landingScreenCaptionBottomLabel: UILabel!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meme = Meme.init(originalImage: nil, memeImage: nil, topCaption: nil, bottomCaption: nil)
    }
    
    @IBAction func launchGallery(_ sender: Any)
    {
        let imageSourceType: UIImagePickerControllerSourceType = .photoLibrary
        handleImageSelection(imageSourceType: imageSourceType)
        
        // Change appState to .captionEditing when image has been selected (see delegate function)
    }
    
    @IBAction func launchCamera(_ sender: Any)
    {
        
    }
}

