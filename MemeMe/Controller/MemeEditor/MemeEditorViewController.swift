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
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var bottomCaptionDistanceFromSendButton: NSLayoutConstraint!
    @IBOutlet weak var topCaptionDistanceFromCloseButton: NSLayoutConstraint!
    
    var meme: Meme!
    var memeCaptions: [UITextField] = []
    let maxLength = 8
    var fontFamilies: [String] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        memeTopCaptionTextField.delegate = self
        memeBottomCaptionTextField.delegate = self
        memeCaptions = [memeTopCaptionTextField, memeBottomCaptionTextField]
        fontFamilies = [FontFamily.arial.rawValue, FontFamily.helvetica.rawValue, FontFamily.times.rawValue]
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        hideKeyboardWhenTappedOutside()
        setupCaptions()
        enableActionButtons(false)
        configureMemeImage()
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

    func generateCompletedMeme(to action: Action)
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
        
        switch action
        {
            case .download:
                UIImageWriteToSavedPhotosAlbum(meme.memeImage!, nil, nil, nil)
            case .share:
                shareMeme(meme: meme.memeImage!)
        }
    }

    func hideOnscreenControls(_ state: Bool)
    {
        sendButton.isHidden = state
        downloadMemeButton.isHidden = state
        changeFontButton.isHidden = state
        cancelMemeButton.isHidden = state
        
        topCaptionDistanceFromCloseButton.constant = state ? -15 : 20
        bottomCaptionDistanceFromSendButton.constant = state ? -30 : 30
    }

    @IBAction func downloadMeme(_ sender: UIButton)
    {
        generateCompletedMeme(to: Action.download)
    }
    
    @IBAction func changeFontFamily(_ sender: Any)
    {
        let font = fontFamilies.first!
        for index in 0..<(fontFamilies.count-1)
        {
            fontFamilies[index] = fontFamilies[index+1]
        }
        
        fontFamilies[fontFamilies.count-1] = font
        
        for caption in memeCaptions
        {
            configureCaptionText(caption: caption, fontFamily: font)
        }
    }
    
    @IBAction func sendMeme(_ sender: Any)
    {
        generateCompletedMeme(to: Action.share)
    }

    @IBAction func cancelMeme(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated: true)
    }
}
