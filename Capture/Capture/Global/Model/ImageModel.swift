//
//  ImageModel.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class ImageModel: NSObject {
    
    var rawImage: UIImage?
    var scaledImage: UIImage?
    
    class var sharedInstance: ImageModel {
        struct Singleton {
            static let instance = ImageModel()
        }
        return Singleton.instance
    }
}

