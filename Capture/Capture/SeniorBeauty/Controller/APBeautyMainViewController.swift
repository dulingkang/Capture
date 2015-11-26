//
//  APBeautyMainViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainViewController: UIViewController, APBeautyMainTopViewDelegate, APBeautyMainMiddleViewDelegate, APBeautyMainBottomViewDelegate {

    var mainTopView: APBeautyMainTopView!
    var mainMiddleView: UIView!
    var mainBottomView: APBeautyMainBottomView!
    
    //MARK: - life cycle
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        
        self.addMainTopView()
        self.addMainMiddleView()
        self.addMainBottomView()
    }
    
    //MARK: - delegate
    //MARK: beautyMainTopView buttons delegate
    func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func undoButtonPressed(sender: UIButton) {
        
    }
    
    func redoButtonPressed(sender: UIButton) {
        
    }
    
    func shareButtonPressed(sender: UIButton) {
        
    }
    
    //MARK: beautyMainMiddleView delegate
    func compareButtonPressed() {
        
    }
    
    //MARK: beautyMainBottomView delegate
    func beautyBottomButtonPressed(sender: UIButton) {
        print(sender.tag)
    }
    
    //MARK: - private method
    func addMainTopView() {
        self.mainTopView = APBeautyMainTopView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        self.mainTopView.apBeautyTopViewDelegate = self
        self.view.addSubview(self.mainTopView)
    }
    
    func addMainMiddleView() {
        self.mainMiddleView = APBeautyMainMiddleView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kBeautyMainBottomHeight - kNavigationHeight))
        self.view.addSubview(self.mainMiddleView)
    }
    
    func addMainBottomView() {
        self.mainBottomView = APBeautyMainBottomView.init(frame: CGRectMake(10, kScreenHeight - kBeautyMainBottomHeight, kScreenWidth, kBeautyMainBottomHeight))
        self.mainBottomView.apBeautyMainBottomViewdelegate = self
        self.view.addSubview(self.mainBottomView)
    }
    
}
