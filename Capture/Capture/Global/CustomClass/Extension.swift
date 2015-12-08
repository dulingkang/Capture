
//
//  Extension.swift
//  Capture
//
//  Created by ShawnDu on 15/11/9.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import Foundation

extension Array where Element : AnyObject {
    func last() -> Element {
        return self[self.count - 1]
    }
}

extension UIView {
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var right: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    var bottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    var top: CGFloat {
        return self.frame.origin.y
    }
    
    var left: CGFloat {
        return self.frame.origin.x
    }
    
    func setX(x: CGFloat) {
        self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
    }
    
    func setY(y: CGFloat) {
        self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height)
    }
    
    func setWidth(width: CGFloat) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height)
    }
    
    func setHeight(height: CGFloat) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)
    }
    
    func setSize(size: CGSize) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)
    }
}

extension UIImage {
    var width : CGFloat{
        return self.size.width
    }
    var height : CGFloat{
        return self.size.height
    }
    
    func sizeThatFits(size: CGSize) -> CGSize {
        
        var imageSize = CGSizeMake(self.size.width / self.scale,
            self.size.height / self.scale)
        
        let widthRatio = imageSize.width / size.width
        let heightRatio = imageSize.height / size.height
        
        if (widthRatio > heightRatio) {
            imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio)
        } else {
            imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio)
        }
        
        return imageSize
    }
}

extension UIImageView {
    var contentSize: CGSize {
        return (self.image?.sizeThatFits(self.bounds.size))!
    }
}
