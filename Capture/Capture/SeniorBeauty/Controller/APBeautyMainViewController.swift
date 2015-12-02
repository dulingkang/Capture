//
//  APBeautyMainViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainViewController: UIViewController, APBeautyMainTopViewDelegate, APBeautyMainMiddleViewDelegate, APBeautyMainBottomViewDelegate, PECropViewControllerDelegate {

    var mainTopView: APBeautyMainTopView!
    var mainMiddleView: APBeautyMainMiddleView!
    var mainBottomView: APBeautyMainBottomView!
    var currentImage: UIImage!
    static let ajustBottomHeight: CGFloat = 90
    var taskManager: SSTaskManager!
    var task: SSTask!
    
    //MARK: - life cycle
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        
        self.addMainTopView()
        self.addMainMiddleView()
        self.addMainBottomView()
        
        self.createTaskManager()
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
    func compareImageViewTaped(long: UILongPressGestureRecognizer) {
        if long.state == .Began || long.state == .Changed{
            self.updateImageView(ImageModel.sharedInstance.rawImage!)

        } else if long.state == .Ended || long.state == .Cancelled {
            self.updateImageView(self.currentImage)
        }
    }

    //MARK: beautyMainBottomView delegate
    func beautyBottomButtonPressed(sender: UIButton) {
        let buttonTag = sender.tag - kBeautyMainBottomButtonStartTag
        if let buttonType = APBottomButtonType(rawValue: buttonTag) {
            switch(buttonType) {
            case .Edit:
                let editVC = PECropViewController.init()
                editVC.delegate = self
                editVC.image = ImageModel.sharedInstance.rawImage
                
                let image = ImageModel.sharedInstance.rawImage
                let width = image!.width
                let height = image!.height
                let length = min(width, height)
                editVC.imageCropRect = CGRectMake((width - length) / 2,(height - length) / 2, length, length)
                self.navigationController?.pushViewController(editVC, animated: true)
                break
            case .Filter:
                break
            case .Magic:
                break
            case .Frame:
                break
            case .Mosaic:
                break
            case .Ballon:
                break
            case .Text:
                break
            }
        }
        
    }
    
    //MARK: PECropViewController delegate
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        self.currentImage = croppedImage
        self.updateImageView(self.currentImage)
    }
    
    //MARK: - private method
    func addMainTopView() {
        self.mainTopView = APBeautyMainTopView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        self.mainTopView.apBeautyTopViewDelegate = self
        self.view.addSubview(self.mainTopView)
    }
    
    func addMainMiddleView() {
        self.mainMiddleView = APBeautyMainMiddleView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kBeautyMainBottomHeight - kNavigationHeight))
        self.mainMiddleView.delegate = self
        self.view.addSubview(self.mainMiddleView)
    }
    
    func addMainBottomView() {
        self.mainBottomView = APBeautyMainBottomView.init(frame: CGRectMake(10, kScreenHeight - kBeautyMainBottomHeight, kScreenWidth, kBeautyMainBottomHeight))
        self.mainBottomView.apBeautyMainBottomViewdelegate = self
        self.view.addSubview(self.mainBottomView)
    }
    
    func updateImageView(image: UIImage) {
        self.mainMiddleView.apMainMiddleScrollView.imageView.image = image
    }
    
    func createTaskManager() {
        SSTask.emptyDirectory()
        taskManager = SSTaskManager.init()
        taskManager.reset()
    }

}
