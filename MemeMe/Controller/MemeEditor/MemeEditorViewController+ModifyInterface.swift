//
//  MemeEditorViewController+ModifyInterface.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 11/5/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController
{
    // MARK: Configure Captions for User to Edit
    func setupCaptions()
    {
        // Set up text fields
        for caption in memeCaptions
        {
            configureCaption(textField: caption)
        }
        
        populateTextField(textField: memeCaptions[0], text: "TOP")
        populateTextField(textField: memeCaptions[1], text: "BOTTOM")
    }
    
    func configureCaption(textField: UITextField)
    {
        configureCaptionText(caption: textField, fontFamily: FontFamily.helvetica.rawValue)
        textField.layer.cornerRadius = 55/2
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange (_ textField: UITextField)
    {
        if textField.hasText
        {
            adjustTextFieldVisibility(textField: textField, colorAlpha: 0.0)
        }
        else
        {
            adjustTextFieldVisibility(textField: textField, colorAlpha: 0.15)
        }
        
        if memeTopCaptionTextField.hasText == true && memeBottomCaptionTextField.hasText == true
        {
            enableActionButtons(true)
        }
        else
        {
            enableActionButtons(false)
        }
    }
    
    // MARK: Present Share Options Modally
    func shareMeme(completedMeme: UIImage)
    {
        let shareController = UIActivityViewController(activityItems: [completedMeme], applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
        shareController.completionWithItemsHandler = {(activityTypeChosen: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            if activityTypeChosen != nil && completed
            {
                UIImageWriteToSavedPhotosAlbum(completedMeme, nil, nil, nil)
                self.memes.append(self.meme)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func configureMemeImage()
    {
        memeImageView.contentMode = .scaleAspectFit
        memeImageView.image = meme.originalImage
    }
    
    func populateTextField(textField: UITextField, text: String?)
    {
        textField.placeholder = text
        textField.text = nil
    }
    
    func adjustTextFieldVisibility(textField: UITextField, colorAlpha: CGFloat)
    {
        textField.backgroundColor = UIColor(white: 1.0, alpha: colorAlpha)
        textField.alpha = 1.0
    }
    
    func enableActionButtons(_ enable: Bool)
    {
        downloadMemeButton.isEnabled = enable
        sendButton.isEnabled = enable
    }
}
