//
//  APBeautyMainViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainViewController: UIViewController, APBeautyMainTopViewDelegate, APBeautyMainMiddleViewDelegate, APBeautyMainBottomViewDelegate, PECropViewControllerDelegate, APShowItemScrollViewDelegate {

    var mainTopView: APBeautyMainTopView!
    var mainMiddleView: APBeautyMainMiddleView!
    var mainBottomView: APBeautyMainBottomView!
    static let ajustBottomHeight: CGFloat = 90
    var taskManager: SSTaskManager!
    var task: SSTask!
    var currentImage: UIImage?
    var isNeedAddTask = true
    var paintingView: PaintingView!
    var itemScrollView: APShowItemScrollView!
    var cancelConfirmView: APCancelConfirmView!
    
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
    
    func itemScrollButtonPressed(sender: UIButton) {
        paintingView.setstampPicName(self.itemScrollView.imageIdentitier! + String(sender.tag - kItemScrollViewStartTag))
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
                var nameArray: [String] = []
                for i in 0...6 {
                    let string = "pic" + String(i)
                    nameArray.append(string)
                }
                self.addItemScrollView(nameArray, identifier: "pic")
                paintingView = PaintingView.init(frame: self.mainMiddleView.apMainMiddleScrollView.imageView.frame)
                paintingView.backgroundColor = UIColor.clearColor()
                self.mainMiddleView.apMainMiddleScrollView.addSubview(paintingView)
                paintingView.setstampPicName("pic0")
                paintingView.imageSize = 30
                self.addCancelConfirmView()
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
    //MARK: add views
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
    
    private func addItemScrollView(nameArray: [String], identifier: String ) {
        itemScrollView = APShowItemScrollView.init(frame: CGRectMake(0, kScreenHeight, kScreenWidth, kBeautyMainBottomHeight), imageNameArray: nameArray)
        itemScrollView.imageIdentitier = identifier
        itemScrollView.itemScrolldelegate = self
        self.view.addSubview(itemScrollView)
    }
    
    private func addCancelConfirmView(title: String) {
        cancelConfirmView = APCancelConfirmView.init(frame: CGRectMake(0, -kNavigationHeight, kScreenWidth, kNavigationHeight))
        cancelConfirmView.title = title
        self.view.addSubview(cancelConfirmView)
    }
    
    //MARK: other private method
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
    
    private func itemScrollViewAppearWithAnimation() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.itemScrollView.frame = CGRectMake(0, kScreenHeight - kBeautyMainBottomHeight, kScreenWidth, kBeautyMainBottomHeight)
        }
    }
    
    private func switchToDetailViewWithAnimation() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainBottomView.frame = CGRectMake(self.mainBottomView.frame.origin.x, kScreenHeight, self.mainBottomView.width, self.mainBottomView.height)
            self.mainTopView.frame = CGRectMake(self.mainTopView.frame.origin.x, -self.mainTopView.height, self.mainTopView.width, self.mainTopView.height)
            }) { (complete) -> Void in
                if complete {
                    self.itemScrollViewAppearWithAnimation()
                }
        }
    }

}
