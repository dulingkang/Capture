//
//  APBeautyMainMiddleView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/26.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

protocol APBeautyMainMiddleViewDelegate {
    func compareButtonPressed()
}

class APBeautyMainMiddleView: UIView {
    
    var apBeautyMainMiddleViewDelegate: APBeautyMainMiddleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - event response
    func compareButtonPressed(sender: UIButton) {
        self.apBeautyMainMiddleViewDelegate?.compareButtonPressed()
    }
    
    //MARK: - private method
    private func initViews() {
        let apMainMiddleScrollView = APBeautyMainMiddleScrollView.init(frame: CGRectMake(0, 0, kScreenWidth, self.height - 30))
        self.addSubview(apMainMiddleScrollView)
        let compareNormalImage = UIImage(named: "compareNormal")
        let comparePressImage = UIImage(named: "comparePress")
        let buttonWidth = compareNormalImage?.size.width
        let buttonHeight = compareNormalImage?.size.height
        let compareButton = UIButton.init(frame: CGRectMake(kScreenWidth - buttonWidth!, apMainMiddleScrollView.height - 30, buttonWidth!, buttonHeight!))
        compareButton.setImage(compareNormalImage, forState: UIControlState.Normal)
        compareButton.setImage(comparePressImage, forState: UIControlState.Highlighted)
        compareButton.addTarget(self, action: "compareButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(compareButton)
    }

}
