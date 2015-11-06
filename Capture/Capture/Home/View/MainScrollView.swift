//
//  MainScrollView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/6.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class MainScrollView: UIScrollView, UIScrollViewDelegate {
    
    var buttonWidth:CGFloat!
    var buttonWidthMargin:CGFloat!
    var firstButtonTopMargin:CGFloat!
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func configureViews() {
        buttonWidth = 90
        buttonWidthMargin = (kScreenWidth - buttonWidth!*2)/3
        firstButtonTopMargin = kScreenHeight/2 - buttonWidth!*1.5
        self.backgroundColor = UIColor.clearColor()
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
//        self.addPageControll()
        self.contentSize = CGSizeMake(2*kScreenWidth, kScreenHeight)
        self.addButtons()
    }
    
//    func addPageControll() {
//        let pageControll = UIPageControl.init(frame: CGRectMake(0, self.bounds.size.height - 20, kScreenWidth, 20))
//        pageControll.pageIndicatorTintColor = kRGBA(0.733, g: 0.737, b: 0.741, a: 1.0)
//        pageControll.currentPageIndicatorTintColor = kRGBA(0.443, g: 0.447, b: 0.451, a: 1.0)
//        pageControll.enabled = true
//        pageControll.numberOfPages = 2
//        self.addSubview(pageControll)
//    }
    
    func addButtons() {
        
        let cameraButton = UIButton.init(frame: CGRectMake(buttonWidthMargin, firstButtonTopMargin, buttonWidth, buttonWidth))
        cameraButton.layer.borderWidth = 1
        cameraButton.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(cameraButton)
        
        let beautyButton = UIButton.init(frame: CGRectMake(kScreenWidth - buttonWidthMargin - buttonWidth, firstButtonTopMargin, buttonWidth, buttonWidth))
        beautyButton.layer.borderWidth = 1
        beautyButton.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(beautyButton)
        
        let videoButton = UIButton.init(frame: CGRectMake(buttonWidthMargin, firstButtonTopMargin + 1.5*buttonWidth, buttonWidth, buttonWidth))
        videoButton.layer.borderWidth = 1
        videoButton.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(videoButton)
        
        let adsButton = UIButton.init(frame: CGRectMake(kScreenWidth - buttonWidthMargin - buttonWidth, firstButtonTopMargin + 1.5*buttonWidth, buttonWidth, buttonWidth))
        adsButton.layer.borderWidth = 1
        adsButton.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(adsButton)
        
        let penButton = UIButton.init(frame: CGRectMake(kScreenWidth + buttonWidthMargin, firstButtonTopMargin, buttonWidth, buttonWidth))
        penButton.layer.borderWidth = 1
        penButton.layer.borderColor = UIColor.blueColor().CGColor
        self.addSubview(penButton)
        
        let ads2Button = UIButton.init(frame: CGRectMake(2*kScreenWidth - buttonWidthMargin - buttonWidth, firstButtonTopMargin, buttonWidth, buttonWidth))
        ads2Button.layer.borderWidth = 1
        ads2Button.layer.borderColor = UIColor.blueColor().CGColor
        self.addSubview(ads2Button)
    }

}
