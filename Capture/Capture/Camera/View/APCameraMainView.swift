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
    
}





