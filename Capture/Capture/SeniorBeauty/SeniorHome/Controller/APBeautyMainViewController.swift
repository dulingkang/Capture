//
//  APBeautyMainViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainViewController: UIViewController, APBeautyMainTopViewDelegate, APBeautyMainMiddleViewDelegate, APBeautyMainBottomViewDelegate, PECropViewControllerDelegate, APShowItemScrollViewDelegate, APCancelConfirmViewDelegate, FilterControlDelegate {

    var mainTopView: APBeautyMainTopView!
    var mainMiddleView: APBeautyMainMiddleView!
    var mainBottomView: APBeautyMainBottomView!
    var mainBackBottomView: UIView!
    var taskManager: SSTaskManager!
    var task: SSTask!
    var isNeedAddTask = true
    var paintingView: PaintingView?
    var itemScrollView: APShowItemScrollView?
    var cancelConfirmView: APCancelConfirmView!
    var mosaicView: APMosaicView?
    var filterControlView: FilterControl?
    
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
        paintingView!.setstampPicName(self.itemScrollView!.imageIdentitier! + String(sender.tag - kItemScrollViewStartTag))
    }
    
    //MARK: beautyMainMiddleView delegate
    func compareImageViewTaped(long: UILongPressGestureRecognizer) {
        if long.state == .Began || long.state == .Changed{
            paintingView?.alpha = 0.0
            self.mainMiddleView.apMainMiddleScrollView.imageView.image = ImageModel.sharedInstance.rawImage
            
        } else if long.state == .Ended || long.state == .Cancelled {
            paintingView?.alpha = 1.0
            self.mainMiddleView.apMainMiddleScrollView.imageView.image = ImageModel.sharedInstance.currentImage
        }
    }

    //MARK: cancelConfirm view delegate
    func cancelButtonPressed() {
        self.resetBeautyMainViewWithAnimation()
    }
    
    func confirmButtonPressed() {
        self.resetBeautyMainViewWithAnimation()
        ImageModel.sharedInstance.currentImage = APImageHelper.saveViewToImage(self.mainMiddleView.apMainMiddleScrollView.imageView)
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
                for i in 0...9 {
                    let string = "pic" + String(i)
                    nameArray.append(string)
                }
                self.addItemScrollView(nameArray, identifier: "pic")
                self.addCancelConfirmView((sender.titleLabel?.text)!)
                self.switchToDetailViewWithAnimation()
                if paintingView != nil {
                    paintingView?.removeFromSuperview()
                }
                paintingView = PaintingView.init(frame: CGRectMake(0, 0, self.mainMiddleView.apMainMiddleScrollView.imageView.width, self.mainMiddleView.apMainMiddleScrollView.imageView.height))
                paintingView!.backgroundColor = UIColor.clearColor()
                self.mainMiddleView.apMainMiddleScrollView.imageView.addSubview(paintingView!)
                paintingView!.setstampPicName("pic0")
                paintingView!.imageSize = 30
                break
            case .Mosaic:
                self.addMosaicView()
                self.addCancelConfirmView((sender.titleLabel?.text)!)
                self.addFilterControlView()
                self.switchToDetailViewWithAnimation()
                mosaicView!.setPathColor(UIColor.whiteColor(), strokeColor: UIColor.blackColor())
                break
            }
        }
        
    }
    
    //MARK: PECropViewController delegate
    func cropViewController(controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        ImageModel.sharedInstance.currentImage = croppedImage
    }
    
    func selectedFilterIndex(index: Int) {
        mosaicView!.sizeBrush = CGFloat(index) * 20.0
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
        self.mainBottomView = APBeautyMainBottomView.init(frame: CGRectMake(10, kScreenHeight - kBeautyMainBottomHeight, kScreenWidth - 20, kBeautyMainBottomHeight))
        self.mainBottomView.apBeautyMainBottomViewdelegate = self
        self.view.addSubview(self.mainBottomView)
        mainBackBottomView = UIView.init(frame: CGRectMake(0, kScreenHeight, kScreenWidth, kBeautyMainBottomHeight))
        self.view.addSubview(mainBackBottomView)
    }
    
    private func addItemScrollView(nameArray: [String], identifier: String ) {
        itemScrollView = APShowItemScrollView.init(frame: CGRectMake(0, 0, kScreenWidth, kBeautyMainBottomHeight), imageNameArray: nameArray)
        itemScrollView!.imageIdentitier = identifier
        itemScrollView!.itemScrolldelegate = self
        mainBackBottomView.addSubview(itemScrollView!)
    }
    
    private func addCancelConfirmView(title: String) {
        cancelConfirmView = APCancelConfirmView.init(frame: CGRectMake(0, -kNavigationHeight, kScreenWidth, kNavigationHeight))
        cancelConfirmView.title = title
        cancelConfirmView.delegate = self
        self.view.addSubview(cancelConfirmView)
    }
    
    private func addMosaicView() {
        mosaicView = APMosaicView.init(frame: CGRectMake(0, 0, mainMiddleView.apMainMiddleScrollView.imageView.width, mainMiddleView.apMainMiddleScrollView.imageView.height))
        
        let mosaicImageView = UIImageView(frame: mosaicView!.frame)
        let mosaicImage = APImageHelper.pixelImage(mainMiddleView.apMainMiddleScrollView.imageView.image!)
        
        mosaicImageView.image = mosaicImage
        mosaicView!.setHiddenView(mosaicImageView)
        
        mainMiddleView.apMainMiddleScrollView.imageView.addSubview(mosaicView!)
        self.addFilterControlView()
    }
    
    private func addFilterControlView() {
        if filterControlView == nil {
            filterControlView = FilterControl.init(frame: CGRectMake(kScreenWidth/4, 0, kScreenWidth/2, kBeautyMainBottomHeight))
        }
        filterControlView?.delegate = self
        mainBackBottomView.addSubview(filterControlView!)
    }
    
    //MARK: other private method
    private func updateImageView() {
        if isNeedAddTask {
            if ImageModel.sharedInstance.currentImage != nil {
                self.addTask(ImageModel.sharedInstance.currentImage!)
            }
        }
        self.isNeedAddTask = true
        self.mainMiddleView.apMainMiddleScrollView.imageView.image = ImageModel.sharedInstance.currentImage
        self.mainMiddleView.apMainMiddleScrollView.setImageViewSize()
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
    
    private func switchToDetailViewWithAnimation() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.mainBottomView.setY(kScreenHeight)
            self.mainTopView.setY(-self.mainTopView.height)
            }) { (complete) -> Void in
                if complete {
                    UIView.animateWithDuration(0.3) { () -> Void in
                        self.mainBackBottomView.setY(kScreenHeight - kBeautyMainBottomHeight)
                        self.cancelConfirmView.setY(0)
                    }
                }
        }
    }
    
    private func resetBeautyMainViewWithAnimation() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.itemScrollView?.alpha = 0.0
            self.filterControlView?.alpha = 0.0
            self.cancelConfirmView.alpha = 0.0
            }) { (complete) -> Void in
                if complete {
                    self.mainBackBottomView.setY(kScreenHeight)
                    self.itemScrollView?.removeFromSuperview()
                    self.filterControlView?.removeFromSuperview()
                    self.cancelConfirmView.removeFromSuperview()
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.mainBottomView.setY(kScreenHeight - kBeautyMainBottomHeight)
                        self.mainTopView.setY(0)
                        }, completion: { (complete) -> Void in
                            self.paintingView?.removeFromSuperview()
                            self.mosaicView?.removeFromSuperview()
                    })
                }
        }
    }

}
