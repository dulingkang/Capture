//
//  APCameraMainViewController.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit
import GPUImage

class APCameraMainViewController: UIViewController,UICollectionViewDelegateFlowLayout, APCameraFilterDelegate {

    var cameraManager: APCameraManager!
    var meiYanFilter: GPUImageBilateralFilter?
    var gpuImageView: GPUImageView?
    var cameraView: APCameraMainView?
    var currentFilterIndex: Int?
    var groupFilter: GPUImageFilterGroup?
    var lookupFilter: GPUImageCustomLookupFilter?
    var filterModel: FilterModel!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clearColor()
        self.cameraManager = APCameraManager.init(preset: AVCaptureSessionPresetPhoto, cameraPosition: AVCaptureDevicePosition.Front)
        self.meiYanFilter = GPUImageBilateralFilter.init()
        self.gpuImageView = GPUImageView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenWidth*4/3))
        self.gpuImageView?.fillMode = kGPUImageFillModePreserveAspectRatioAndFill
        self.cameraManager.outputImageOrientation = UIInterfaceOrientation.Portrait
        self.cameraManager.addTarget(self.meiYanFilter)
        self.meiYanFilter?.addTarget(self.gpuImageView)
        self.cameraManager.startCameraCapture()
        self.addCameraView()
        self.cameraView?.preView.addSubview(self.gpuImageView!)
        self.cameraView?.filterView?.filterCollectionDelegate = self
        self.filterModel = FilterModel.sharedInstance
    }
    
    //MARK: - Delegate
    //MARK: cameraFilterDelegate
    func switchFilter(index: Int) {
        self.cameraManager.removeAllTargets()
        self.currentFilterIndex = index
        let lookupImageName = self.filterModel.filterList[index].lookupImageName
        self.lookupFilter = GPUImageCustomLookupFilter.init(lookupImageName: lookupImageName)
        self.setUpGroupFilters(self.lookupFilter!)
        self.cameraManager.addTarget(self.groupFilter)
        self.groupFilter?.addTarget(self.gpuImageView)
    }
    
    //MARK: - private method
    func setUpGroupFilters(lookupFilter: GPUImageCustomLookupFilter) {
        self.groupFilter = GPUImageFilterGroup.init()
        self.groupFilter?.addFilter(self.meiYanFilter)
        self.groupFilter?.initialFilters = [self.meiYanFilter!]
        self.groupFilter?.addFilter(lookupFilter)
        self.meiYanFilter?.addTarget(lookupFilter)
        self.groupFilter?.terminalFilter = lookupFilter
    }
    
    //MARK: - getter setter
    func addCameraView() {
        if (self.cameraView == nil) {
            self.cameraView = APCameraMainView.init(frame: self.view.bounds)
        }
        self.view.addSubview(self.cameraView!)
    }
}

extension APCameraFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kFilterCellWidth, kCameraFilterHeight)
    }
}
