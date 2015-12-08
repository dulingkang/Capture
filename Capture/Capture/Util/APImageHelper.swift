//
//  APImageHelper.swift
//  Capture
//
//  Created by dulingkang on 15/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

struct APImageHelper {
    
    func saveViewToImage(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let newSize = CGSizeMake(view.width, view.height)

        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
}