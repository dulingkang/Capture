//
//  APCameraMainViewController.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit
import GPUImage

//class FilterType<FilterClass: GPUImageOutput where FilterClass: GPUImageInput> {
//    var internalFilter: FilterClass?
//}

class APCameraMainViewController: UIViewController,UICollectionViewDelegateFlowLayout, APCameraFilterDelegate , APCameraMainViewDelegate, GestureViewControl{

    var cameraManager: APCameraManager!
    var meiYanFilter: SSGPUImageBeautyFilter!
    var gpuImageView: GPUImageView?
    var cameraView: APCameraMainView?
    var currentFilterIndex: Int?
    var groupFilter: GPUImageFilterGroup?
    var lookupFilter: GPUImageCustomLookupFilter?
    var filterModel: FilterModel!
    var photoArray: [UIImage] = []
    var gestureView: GestureView?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        self.cameraManager = APCameraManager.init(preset: AVCaptureSessionPresetPhoto, cameraPosition: AVCaptureDevicePosition.Front)
        meiYanFilter = SSGPUImageBeautyFilter.init()
        self.gpuImageView = GPUImageView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenWidth*4/3))
        self.gpuImageView?.fillMode = kGPUImageFillModePreserveAspectRatioAndFill
        self.cameraManager.outputImageOrientation = UIInterfaceOrientation.Portrait
        self.cameraManager.addTarget(self.meiYanFilter)
        self.meiYanFilter.addTarget(self.gpuImageView)
        self.cameraManager.startCameraCapture()
        self.addCameraView()
        self.cameraView?.preView.addSubview(self.gpuImageView!)
        self.cameraView?.filterView?.filterCollectionDelegate = self
        self.cameraView?.delegate = self
        self.filterModel = FilterModel.sharedInstance
        
        currentFilterIndex = 0
        self.addGestureView()
    }
    
    //MARK: - Delegate
    //MARK: cameraFilterDelegate
    func switchFilter(index: Int) {
        self.meiYanFilter?.removeAllTargets()
        self.groupFilter?.removeAllTargets()
        self.cameraManager.removeAllTargets()
        self.currentFilterIndex = index
        let lookupImageName = self.filterModel.filterList[index].lookupImageName
        print(lookupImageName)
        self.lookupFilter = GPUImageCustomLookupFilter.init(lookupImageName: lookupImageName)
        self.setUpGroupFilters(self.lookupFilter!)
        self.cameraManager.addTarget(self.groupFilter)
        self.groupFilter?.addTarget(self.gpuImageView)
    }

    //MARK: cameraMainView delegate
    func browsePhoto(array: NSArray) {
        self.photoArray = array as! [UIImage]
    }
    
    func takePhoto() {
        self.cameraManager.capturePhotoAsImageProcessedUpToFilter(lookupFilter) { (processedImage, error) -> Void in
            if error != nil {
                print("takePhotoError:\(error)")
            } else {
                if processedImage != nil {
                    self.takePhotoFinished(processedImage)
                }
            }
        }
    }
    
    func switchCamera() {
        self.cameraManager.rotateCamera()
        self.switchFilter(currentFilterIndex!)
    }
    
    func closeMainView() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: gestureview delegate
    func leftSwipe() {
        cameraView?.filterView?.filterCellScrollToLeft(true)
    }
    
    func rightSwipe() {
        cameraView?.filterView?.filterCellScrollToLeft(false)
    }
    
    //MARK: - private method
    func setUpGroupFilters(lookupFilter: GPUImageCustomLookupFilter) {
        self.groupFilter = GPUImageFilterGroup.init()
        self.groupFilter?.addTarget(self.meiYanFilter)
        self.meiYanFilter?.addTarget(lookupFilter)
        self.groupFilter?.initialFilters = [self.meiYanFilter!]
        self.groupFilter?.terminalFilter = lookupFilter
    }
    
    func takePhotoFinished(image: UIImage) {
        CustomPhotoAlbum.sharedInstance.saveImage(image)
        self.cameraView?.addPreviewImageView()
        self.cameraView?.addNumberLabel()
        self.cameraView?.setImageForPreviewImageView(image)
    }
    
    //MARK: - getter setter
    func addCameraView() {
        if (self.cameraView == nil) {
            self.cameraView = APCameraMainView.init(frame: self.view.bounds)
        }
        self.view.addSubview(self.cameraView!)
    }
    
    func addGestureView() {
        var height = kCameraBottomHeight
        if kScreenHeight == kIphone4sHeight {
            height = kCameraBottom4SHeight
        }
        if gestureView == nil {
            gestureView = GestureView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight - kNavigationHeight - height - kCameraFilterHeight))
        }
        gestureView?.gestureControl = self
        self.view.addSubview(gestureView!)
    }
}

extension APCameraFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kFilterCellWidth, kCameraFilterHeight)
    }
}
