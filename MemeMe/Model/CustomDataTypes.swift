//
//  CustomDataTypes.swift
//  MemeMe
//
//  Created by Jase-Omeileo West on 10/28/17.
//  Copyright © 2017 Omeileo. All rights reserved.
//

import Foundation

enum ImageOriginMethod
{
    case gallerySelection, cameraCapture
}

enum AppState
{
    case imageSelection, captionEditing
}

enum Action
{
    case share, download
}

enum FontFamily: String
{
    case helvetica = "HelveticaNeue-CondensedBlack"
    case arial = "Arial-BoldItalicMT"
    case times = "TimesNewRomanPS-BoldItalicMT"
}
