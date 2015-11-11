//
//  HomeViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/5.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    
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

}
