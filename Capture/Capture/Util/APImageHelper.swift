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

        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
    static func pixelImage(image: UIImage) -> UIImage {
        let inputImage = CIImage(image: image)
        let r = inputImage?.extent
        let scale = (max(r!.size.width, r!.size.height) / 60.0) * UIScreen.mainScreen().scale
        
        let maskImage = CIImage.init(color: CIColor(red: 0.0, green: 1.0, blue: 1.0))
        
        let filter = CIFilter(name: "CIPixellate")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(scale, forKey: "inputScale")
        let pixellatedImage = filter?.outputImage
        
        let maskFilter = CIFilter(name: "CIBlendWithMask")
        maskFilter?.setValue(pixellatedImage, forKey: kCIInputImageKey)
        maskFilter?.setValue(maskImage, forKey: "inputMaskImage")
        maskFilter?.setValue(inputImage, forKey: kCIInputBackgroundImageKey)
       
        let result = maskFilter?.outputImage
        
        return UIImage(CIImage: result!)
    }
}