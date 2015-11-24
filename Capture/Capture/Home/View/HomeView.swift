//
//  MainScrollView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/6.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func cameraButtonPressed()
    func beautyButtonPressed()
}

class HomeView: UIView, UIScrollViewDelegate {
    
    var buttonWidth:CGFloat!
    var buttonWidthMargin:CGFloat!
    var scrollView:UIScrollView!
    var pageControll:UIPageControl!
    var homeViewdelegate: HomeViewDelegate?
   
    
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
        self.addTopImageView()
        self.addScrollView()
        self.addBottomView()
    }
    
    //MARK: scrollview delegate
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (targetContentOffset.memory.x > kScreenWidth/2) {
            pageControll.currentPage = 1
        } else {
            pageControll.currentPage = 0
        }
    }
    
    //MARK: event response
    func cameraButtonPressed() {
        self.homeViewdelegate?.cameraButtonPressed()
    }
    
    func beautyButtonPressed() {
        self.homeViewdelegate?.beautyButtonPressed()
    }
    
    //MARK: private method
    func addTopImageView() {
        let topImageViewWidth:CGFloat = 250.0
        let topImageViewHeight:CGFloat = 90.0
        let topImageView = UIImageView.init(frame: CGRectMake((kScreenWidth - topImageViewWidth)/2, 0.1*kScreenHeight, topImageViewWidth, topImageViewHeight))
        topImageView.layer.borderWidth = 1
        topImageView.layer.borderColor = UIColor.redColor().CGColor
        self.addSubview(topImageView)
    }
    
    func addScrollView() {
        scrollView = UIScrollView.init(frame: CGRectMake(0, kScreenHeight/2 - 1.5*buttonWidth, kScreenWidth, 2.5*buttonWidth))
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(2*kScreenWidth, 2.5*buttonWidth)
        scrollView.delegate = self
        self.addSubview(scrollView)
        self.addScrollButtons()
    }
    
    func addBottomView() {
        self.addPageControll()
    }
    
    func addPageControll() {
        let pageControllWidth:CGFloat = 100.0
        pageControll = UIPageControl.init(frame: CGRectMake((kScreenWidth - pageControllWidth)/2, self.bounds.size.height - 20, pageControllWidth, 20))
        pageControll.pageIndicatorTintColor = UIColor.grayColor()
        pageControll.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControll.enabled = true
        pageControll.numberOfPages = 2
        self.addSubview(pageControll)
    }
    
    func addScrollButtons() {
        
        let cameraButton = UIButton.init(frame: CGRectMake(buttonWidthMargin, 0, buttonWidth, buttonWidth))
        cameraButton.layer.borderWidth = 1
        cameraButton.layer.borderColor = UIColor.redColor().CGColor
        cameraButton.addTarget(self, action: "cameraButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(cameraButton)
        
        let beautyButton = UIButton.init(frame: CGRectMake(kScreenWidth - buttonWidthMargin - buttonWidth, 0, buttonWidth, buttonWidth))
        beautyButton.layer.borderWidth = 1
        beautyButton.layer.borderColor = UIColor.redColor().CGColor
        beautyButton.addTarget(self, action: "beautyButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(beautyButton)
        
        let videoButton = UIButton.init(frame: CGRectMake(buttonWidthMargin, 1.5*buttonWidth, buttonWidth, buttonWidth))
        videoButton.layer.borderWidth = 1
        videoButton.layer.borderColor = UIColor.redColor().CGColor
        scrollView.addSubview(videoButton)
        
        let adsButton = UIButton.init(frame: CGRectMake(kScreenWidth - buttonWidthMargin - buttonWidth,  1.5*buttonWidth, buttonWidth, buttonWidth))
        adsButton.layer.borderWidth = 1
        adsButton.layer.borderColor = UIColor.redColor().CGColor
        scrollView.addSubview(adsButton)
        
        let penButton = UIButton.init(frame: CGRectMake(kScreenWidth + buttonWidthMargin, 0, buttonWidth, buttonWidth))
        penButton.layer.borderWidth = 1
        penButton.layer.borderColor = UIColor.blueColor().CGColor
        scrollView.addSubview(penButton)
        
        let ads2Button = UIButton.init(frame: CGRectMake(2*kScreenWidth - buttonWidthMargin - buttonWidth, 0, buttonWidth, buttonWidth))
        ads2Button.layer.borderWidth = 1
        ads2Button.layer.borderColor = UIColor.blueColor().CGColor
        scrollView.addSubview(ads2Button)
    }
}
