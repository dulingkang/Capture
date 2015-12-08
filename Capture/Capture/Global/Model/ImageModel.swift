//
//  ImageModel.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

let kCurrentImage = "currentImage"
class ImageModel: NSObject {
    
    var rawImage: UIImage?
    dynamic var currentImage: UIImage?
    var scaledImage: UIImage?
    
    static let sharedInstance = ImageModel()
}

