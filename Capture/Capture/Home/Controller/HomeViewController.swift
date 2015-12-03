//
//  HomeViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/5.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: life cycle
    override func viewDidLoad() {
        
        let homeView = HomeView.init(frame: self.view.bounds)
        homeView.homeViewdelegate = self
        self.view.addSubview(homeView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: homeView delegate
    func cameraButtonPressed() {
        let cameraVC = APCameraMainViewController()
        self.navigationController?.pushViewController(cameraVC, animated: true)
    }
    
    func beautyButtonPressed() {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: {})
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            ImageModel.sharedInstance.rawImage = image
            ImageModel.sharedInstance.currentImage = image
            let beautyMainVC = APBeautyMainViewController.init()
            self.navigationController?.pushViewController(beautyMainVC, animated: true)
            picker.dismissViewControllerAnimated(true, completion: {
                () -> Void in

            })
            

    }

}
