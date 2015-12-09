//
//  APShowItemScrollView.swift
//  Capture
//
//  Created by ShawnDu on 15/12/5.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

let kItemScrollViewStartTag: Int = 11030

protocol APShowItemScrollViewDelegate {
    func itemScrollButtonPressed(sender: UIButton)
}

class APShowItemScrollView: UIScrollView {
    
    var imageNameArray: [String] = []
    let imageWidth: CGFloat = 35
    let margin: CGFloat = 6
    var imageIdentitier: String?
    var itemScrolldelegate: APShowItemScrollViewDelegate?
    
    init(frame: CGRect, imageNameArray: [String]) {
        super.init(frame: frame)
        self.imageNameArray = imageNameArray
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    private func initViews() {
        self.backgroundColor = UIColor.clearColor()
        let count = self.imageNameArray.count
        self.contentSize = CGSizeMake((imageWidth + margin) * CGFloat(count), imageWidth)
        for i in 0..<count {
            let imageButton = UIButton.init(frame: CGRectMake(CGFloat(i) * (imageWidth + margin), 0, imageWidth, imageWidth))
            imageButton.userInteractionEnabled = true
            imageButton.setImage(UIImage(named:imageNameArray[i]), forState: UIControlState.Normal)
            imageButton.contentMode = UIViewContentMode.ScaleAspectFit
            imageButton.tag = kItemScrollViewStartTag + i
            imageButton.addTarget(self, action: "itemScrollButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(imageButton)
        }
    }
    
    func itemScrollButtonPressed(sender: UIButton) {
        for item in self.subviews {
            if item.tag == sender.tag {
                item.layer.borderColor = UIColor.orangeColor().CGColor
                item.layer.borderWidth = 1
            } else {
                item.layer.borderWidth = 0
            }
        }
        self.itemScrolldelegate?.itemScrollButtonPressed(sender)
    }

}
