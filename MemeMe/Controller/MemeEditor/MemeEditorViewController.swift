//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 11/28/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController
{
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var memeTopCaptionTextField: UITextField!
    @IBOutlet weak var memeBottomCaptionTextField: UITextField!
    @IBOutlet weak var cancelMemeButton: UIButton!
    @IBOutlet weak var downloadMemeButton: UIButton!
    @IBOutlet weak var changeFontButton: UIButton!
    
    var meme: Meme!
    var memeCaptions: [UITextField] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        memeTopCaptionTextField.delegate = self
        memeBottomCaptionTextField.delegate = self 
        
        meme = Meme.init(originalImage: nil, memeImage: nil, topCaption: nil, bottomCaption: nil)
        memeCaptions = [memeTopCaptionTextField, memeBottomCaptionTextField]
        
        hideKeyboardWhenTappedOutside()
        
        setupCaptions()
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        unsubcribeFromKeyboardNotifcations()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }

    override func keyboardWillShow(_ notification: Notification)
    {
        resetView()
        
        if (memeBottomCaptionTextField.isFirstResponder)
        {
            super.keyboardWillShow(notification)
        }
    }

    func generateCompletedMeme()
    {
        meme.topCaption = memeTopCaptionTextField.text!
        meme.bottomCaption = memeBottomCaptionTextField.text!
        
        // Hide onscreen controls
        hideOnscreenControls(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Unhide onscreen controls
        hideOnscreenControls(false)
        
        meme.memeImage = memedImage
    }

    func hideOnscreenControls(_ state: Bool)
    {
        sendButton.isHidden = state
        downloadMemeButton.isHidden = state
        changeFontButton.isHidden = state
        cancelMemeButton.isHidden = state
    }

    @IBAction func downloadMeme(_ sender: UIButton)
    {
        // Allow download of meme if both Caption fields contain text
        generateCompletedMeme()
        
        if let meme = meme.memeImage
        {
            UIImageWriteToSavedPhotosAlbum(meme, nil, nil, nil)
        }
    }

    @IBAction func cancelMeme(_ sender: UIButton)
    {
        
    }
}
