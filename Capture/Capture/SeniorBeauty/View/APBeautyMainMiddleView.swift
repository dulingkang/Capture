//
//  APBeautyMainMiddleView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/26.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

protocol APBeautyMainMiddleViewDelegate {
    func compareImageViewTaped(long: UILongPressGestureRecognizer)
}

class APBeautyMainMiddleView: UIView {
    
    var delegate: APBeautyMainMiddleViewDelegate?
    var apMainMiddleScrollView: APBeautyMainMiddleScrollView!
    var compareImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - event response
    func compareImageViewTaped(long: UILongPressGestureRecognizer) {
        let compareNormalImage = UIImage(named: "compareNormal")
        let comparePressImage = UIImage(named: "comparePress")
        if long.state == .Began || long.state == .Changed {
            self.compareImageView.image = comparePressImage
            
        } else if long.state == .Ended || long.state == .Cancelled {
            self.compareImageView.image = compareNormalImage
        }
        self.delegate?.compareImageViewTaped(long)
    }
    
    //MARK: - private method
    private func initViews() {
        apMainMiddleScrollView = APBeautyMainMiddleScrollView.init(frame: CGRectMake(0, 0, kScreenWidth, self.height - 30))
        self.addSubview(apMainMiddleScrollView)
        let compareNormalImage = UIImage(named: "compareNormal")
        let buttonWidth = compareNormalImage?.size.width
        let buttonHeight = compareNormalImage?.size.height
        compareImageView = UIImageView.init(frame: CGRectMake(kScreenWidth - buttonWidth!, apMainMiddleScrollView.height - 30, buttonWidth!, buttonHeight!))
        compareImageView.image = compareNormalImage
        compareImageView.userInteractionEnabled = true
        let long = UILongPressGestureRecognizer.init(target: self, action: "compareImageViewTaped:")
        long.minimumPressDuration = 0.2
        compareImageView.addGestureRecognizer(long)
        self.addSubview(compareImageView)
    }

}
