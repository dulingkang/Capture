//
//  APImageHelper.swift
//  Capture
//
//  Created by dulingkang on 15/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

struct APImageHelper {
    
    static func saveViewToImage(imageView: UIImageView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, true, 0)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let newSize = imageView.image!.size

        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
}