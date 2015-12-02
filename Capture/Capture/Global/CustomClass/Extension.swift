
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
}

extension UIImage {
    var width : CGFloat{
        return self.size.width
    }
    var height : CGFloat{
        return self.size.height
    }
}
