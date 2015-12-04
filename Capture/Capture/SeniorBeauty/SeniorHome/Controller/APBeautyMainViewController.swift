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
    static let ajustBottomHeight: CGFloat = 90
    var taskManager: SSTaskManager!
    var task: SSTask!
    var currentImage: UIImage?
    var isNeedAddTask = true
    var paintingView: PaintingView!
    
    //MARK: - life cycle
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    deinit {
        ImageModel.sharedInstance.removeObserver(self, forKeyPath: kCurrentImage)
    }
    
    override func viewDidLoad() {
        
        self.addMainTopView()
        self.addMainMiddleView()
        self.addMainBottomView()
        self.createTaskManager()
        self.addTask(ImageModel.sharedInstance.currentImage!)
        ImageModel.sharedInstance.addObserver(self, forKeyPath: kCurrentImage, options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == kCurrentImage {
            self.updateImageView()
        }
    }
    //MARK: - delegate
    //MARK: beautyMainTopView buttons delegate
    func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func undoButtonPressed(sender: UIButton) {
        if let task = taskManager.undo() {
            if let image = task.image {
                self.isNeedAddTask = false
                ImageModel.sharedInstance.currentImage = image
            }
            self.updateUndoRedoButtonStates()
        }
    }
    
    func redoButtonPressed(sender: UIButton) {
        if let task = taskManager.redo() {
            if let image = task.image {
                self.isNeedAddTask = false
                ImageModel.sharedInstance.currentImage = image
            }
            self.updateUndoRedoButtonStates()
        }
    }
    
    func shareButtonPressed(sender: UIButton) {
        
    }
    
    //MARK: beautyMainMiddleView delegate
    func compareImageViewTaped(long: UILongPressGestureRecognizer) {
        if long.state == .Began || long.state == .Changed{
            self.currentImage = ImageModel.sharedInstance.currentImage
            self.isNeedAddTask = false
            ImageModel.sharedInstance.currentImage = ImageModel.sharedInstance.rawImage
            
        } else if long.state == .Ended || long.state == .Cancelled {
            self.isNeedAddTask = false
            ImageModel.sharedInstance.currentImage = self.currentImage
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
                
                let image = ImageModel.sharedInstance.currentImage
                editVC.image = image
                let width = image!.width
                let height = image!.height
                let length = min(width, height)
                editVC.imageCropRect = CGRectMake((width - length) / 2,(height - length) / 2, length, length)
                self.navigationController?.pushViewController(editVC, animated: true)
                break
            case .Filter:
                let filterListVC = FilterListViewController.init()
                self.navigationController?.pushViewController(filterListVC, animated: true)
                break
            case .Magic:
                paintingView = PaintingView.init(frame: self.mainMiddleView.apMainMiddleScrollView.imageView.frame)
                paintingView.backgroundColor = UIColor.clearColor()
                self.mainMiddleView.apMainMiddleScrollView.addSubview(paintingView)
                paintingView.setstampPicName("pic_0")
                paintingView.imageSize = 30
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
        ImageModel.sharedInstance.currentImage = croppedImage
    }
    
    //MARK: - private method
    private func addMainTopView() {
        self.mainTopView = APBeautyMainTopView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        self.mainTopView.apBeautyTopViewDelegate = self
        self.view.addSubview(self.mainTopView)
    }
    
    private func addMainMiddleView() {
        self.mainMiddleView = APBeautyMainMiddleView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kBeautyMainBottomHeight - kNavigationHeight))
        self.mainMiddleView.delegate = self
        self.view.addSubview(self.mainMiddleView)
    }
    
    private func addMainBottomView() {
        self.mainBottomView = APBeautyMainBottomView.init(frame: CGRectMake(10, kScreenHeight - kBeautyMainBottomHeight, kScreenWidth, kBeautyMainBottomHeight))
        self.mainBottomView.apBeautyMainBottomViewdelegate = self
        self.view.addSubview(self.mainBottomView)
    }
    
    private func updateImageView() {
        if isNeedAddTask {
            self.addTask(ImageModel.sharedInstance.currentImage!)
        }
        self.isNeedAddTask = true
        self.mainMiddleView.apMainMiddleScrollView.imageView.image = ImageModel.sharedInstance.currentImage
    }
    
    private func createTaskManager() {
        SSTask.emptyDirectory()
        taskManager = SSTaskManager.init()
        taskManager.reset()
    }
    
    private func addTask(image: UIImage) {
        let task = SSTask.init()
        task.image = image
        taskManager.addTask(task)
        self.updateUndoRedoButtonStates()
    }
    
    private func updateUndoRedoButtonStates() {
        self.mainTopView.undoButton.enabled = self.taskManager.undoable()
        self.mainTopView.redoButton.enabled = self.taskManager.redoable()
    }

}
