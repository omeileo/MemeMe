//
//  MemeEditorViewController+SetupInterface.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 11/5/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import AVFoundation
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
        
        enableCaptions(false)
    }
    
    func configureCaption(textField: UITextField)
    {
        let memeCaptionAttributes: [String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
            NSAttributedStringKey.strokeWidth.rawValue: -6.00]
        
        textField.defaultTextAttributes = memeCaptionAttributes
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: Setup Buttons for First Use
    func setupButtons()
    {
    }
}
