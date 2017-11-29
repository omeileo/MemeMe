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
    func shareMeme(meme: UIImage)
    {
        let shareController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        present(shareController, animated: true) {
            UIImageWriteToSavedPhotosAlbum(meme, nil, nil, nil)
        }
    }
    
    func addImageToView(image: UIImage)
    {
        
    }
    
    func enableCaptions(_ state: Bool)
    {
        for caption in memeCaptions
        {
            caption.isEnabled = state
            adjustTextFieldVisibility(textField: caption, colorAlpha: 0.15)
        }
        
        if state == true
        {
            populateTextField(textField: memeCaptions[0], text: "TOP")
            populateTextField(textField: memeCaptions[1], text: "BOTTOM")
        }
        else
        {
            for caption in memeCaptions
            {
                populateTextField(textField: caption, text: nil)
            }
        }
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
    
    func enableActionButtons(_ state: Bool)
    {
        downloadMemeButton.isEnabled = state
        sendButton.isEnabled = state
    }
}
