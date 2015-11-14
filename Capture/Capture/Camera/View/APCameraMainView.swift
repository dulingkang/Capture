//
//  APCameraMainView.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

class APCameraMainView: UIView {
    
    var preView: UIView!
    var topView: UIView!
    var filterView: APCameraFilterCollectionView?
    var bottomView: UIView!
    var albumButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: event response
    func topButtonPressed(button: UIButton) {
        
    }
    
    func albumButtonPressed(sender: UIButton) {
        
    }
    
    func triggerButtonPressed(sender: UIButton) {
        
    }
    
    func closeButtonPressed(sender: UIButton) {
        
    }
    
    //MARK: private method
    func initViews() {
        self.backgroundColor = kRGBA(0.447, g: 0.894, b: 0.973, a: 1.0)
        self.addPreView()
        self.addTopView()
        self.addSliderView()
        self.addFilterView()
        self.addBottomView()
    }
    
    func addPreView() {
        self.preView = UIView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenWidth*4/3))
        self.addSubview(self.preView)
    }
    
    func addTopView() {
        self.topView = UIView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        self.topView.backgroundColor = UIColor.blackColor()
        self.addSubview(self.topView)
        self.addTopButtons()
    }
    
    func addSliderView() {
        
    }
    
    func addFilterView() {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.filterView = APCameraFilterCollectionView.init(frame: CGRectMake(0, kScreenHeight - kCameraBottomHeight - kCameraFilterHeight, kScreenWidth, kCameraFilterHeight), collectionViewLayout: layout)
        self.addSubview(self.filterView!)
    }
    
    func addBottomView() {
        if (self.bottomView == nil) {
            self.bottomView = UIView.init(frame: CGRectMake(0, kScreenHeight - kCameraBottomHeight, kScreenWidth, kCameraBottomHeight))
        }
        self.bottomView.backgroundColor = UIColor.clearColor()
        self.addSubview(self.bottomView)
        self.addAlbumButton()
        self.addTriggerButton()
        self.addCloseButton()
    }
    
    func addTopButtons() {
        let normalNameArray = ["xiaoka_ratio_normal_01", "xiaoka_black_normal", "timer_normal", "flash_normal", "switchNormal"]
        let pressNameArray = ["xiaoka_ratio_press_01", "xiaoka_black_press", "timer_press", "flash_press", "switchPress"]
        for index in 0...normalNameArray.count-1 {
            let floatIndex: CGFloat = CGFloat(index)
            let button = UIButton.init(frame: CGRectMake(kScreenWidth*floatIndex/5, 0, kScreenWidth/5, kNavigationHeight))
            button.tag = kCameraViewTopButtonStartTag + index
            let imageNomal = normalNameArray[index]
            let imagePress = pressNameArray[index]
            button.setImage(UIImage(named: imageNomal), forState: UIControlState.Normal)
            button.setImage(UIImage(named: imagePress), forState: UIControlState.Selected)
            button.addTarget(self, action: "topButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.topView.addSubview(button)
        }
    }
    
    func addAlbumButton() {
        self.albumButton = UIButton.init(frame: CGRectMake(kScreenWidth/8, (kCameraBottomHeight - kButtonClickWidth)/2, kButtonClickWidth, kButtonClickWidth))
        self.albumButton.backgroundColor = UIColor.clearColor()
        self.albumButton.setImage(UIImage(named: "cameraAlbumNormal"), forState: UIControlState.Normal)
        self.albumButton.setImage(UIImage(named: "cameraAlbumPress"), forState: UIControlState.Selected)
        self.albumButton.addTarget(self, action: "albumButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.bottomView.addSubview(self.albumButton)
    }
    
    func addTriggerButton() {
        let triggerNormalImage = UIImage(named: "cameraTriggerNormal")
        let triggerButton = UIButton.init(frame: CGRectMake((kScreenWidth - (triggerNormalImage?.size.width)!)/2, (kCameraBottomHeight - (triggerNormalImage?.size.height)!)/2, (triggerNormalImage?.size.width)!, (triggerNormalImage?.size.height)!))
        triggerButton.backgroundColor = UIColor.clearColor()
        triggerButton.setImage(triggerNormalImage, forState: UIControlState.Normal)
        triggerButton.setImage(UIImage(named: "cameraTriggerPress"), forState: UIControlState.Selected)
        triggerButton.addTarget(self, action: "triggerButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.bottomView.addSubview(triggerButton)
    }
    
    func addCloseButton() {
        let closeButton = UIButton.init(frame: CGRectMake(kScreenWidth*7/8 - kButtonClickWidth, (kCameraBottomHeight - kButtonClickWidth)/2, kButtonClickWidth, kButtonClickWidth))
        closeButton.backgroundColor = UIColor.clearColor()
        closeButton.setImage(UIImage(named: "cameraCloseNormal"), forState: UIControlState.Normal)
        closeButton.setImage(UIImage(named: "cameraClosePress"), forState: UIControlState.Selected)
        closeButton.addTarget(self, action: "closeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.bottomView.addSubview(closeButton)
    }
    
}












