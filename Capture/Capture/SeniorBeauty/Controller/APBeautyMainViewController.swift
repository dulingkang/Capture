//
//  APBeautyMainViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainViewController: UIViewController, APBeautyMainTopViewDelegate {

    var mainMiddleView: APBeautyMainMiddleView!
    
    //MARK: - life cycle
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        
        self.addMainTopView()
        self.addMainMiddleView()
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
    
    
    //MARK: - private method
    func addMainTopView() {
        let mainTopView = APBeautyMainTopView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        mainTopView.apBeautyTopViewDelegate = self
        self.view.addSubview(mainTopView)
    }
    
    func addMainMiddleView() {
        self.mainMiddleView = APBeautyMainMiddleView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kBeautyMainBottomHeight - kNavigationHeight))
        self.view.addSubview(self.mainMiddleView)
    }
}
