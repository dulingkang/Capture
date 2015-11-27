//
//  SSButton.swift
//  Capture
//
//  Created by ShawnDu on 15/11/26.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

enum SSButtonType: Int {
    case Top, Bottom, Left, Right
}

class SSButton: UIButton {

    var ssButtonType = SSButtonType.Bottom
    
    var ssNormalTitleColor: UIColor {
        set {
            self.setTitleColor(self.ssNormalTitleColor, forState: UIControlState.Normal)
        }
        get {
            return self.ssNormalTitleColor
        }
    }

    var ssSelectedTitleColor: UIColor {
        set {
            self.setTitleColor(self.ssSelectedTitleColor, forState: UIControlState.Highlighted)
        }
        get {
            return self.ssSelectedTitleColor
        }
    }
    
    var ssTitleLabelFontSize: CGFloat {
        set {
            self.titleLabel?.font = UIFont.systemFontOfSize(self.ssTitleLabelFontSize)
        }
        get {
            return self.ssTitleLabelFontSize
        }
    }
    
    override func awakeFromNib() {
        self.configure()
    }

    init(frame: CGRect, type: SSButtonType, normalImageName: String, pressImageName: String) {
        super.init(frame: frame)
        self.ssButtonType = type
        self.config(normalImageName, pressImageName: pressImageName)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func config(normalImageName: String, pressImageName: String) {
        self.setImage(UIImage(named: normalImageName), forState: UIControlState.Normal)
        self.setImage(UIImage(named: pressImageName), forState: UIControlState.Highlighted)
        self.configure()
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageWith = self.currentImage?.size.width
        let imageHeight = self.currentImage?.size.height
        var imageOriginX = (self.width - imageWith!)/2
        var imageOriginY: CGFloat = 0
        
        switch (self.ssButtonType) {
        case .Top:
            imageOriginY = 20
        case .Bottom:
            break
        case .Left:
            break
        case .Right:
            imageOriginX = 0
        }

        return CGRectMake(imageOriginX, imageOriginY, imageWith!, imageHeight!)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        var titleWidth = self.currentImage?.size.width
        let titleHeight: CGFloat = 20
        let titleOriginX = (self.width - (self.currentImage?.size.width)!)/2
        var titleOriginY: CGFloat = 0
        
        switch (self.ssButtonType) {
        case .Top:
            break
        case .Bottom:
            titleOriginY = (self.currentImage?.size.height)!
        case .Left:
            titleOriginY = (self.height - titleHeight)/2
            titleWidth = self.width - (self.currentImage?.size.width)!
        case .Right:
            titleOriginY = (self.height - titleHeight)/2
        }

        return CGRectMake(titleOriginX, titleOriginY, titleWidth!, titleHeight)
    }
    
    private func configure() {
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.greenColor(), forState: UIControlState.Highlighted)
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
    }
}
