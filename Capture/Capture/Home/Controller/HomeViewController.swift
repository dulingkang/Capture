//
//  HomeViewController.swift
//  Capture
//
//  Created by ShawnDu on 15/11/5.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK - life cycle
    override func viewDidLoad() {
        
        let mainScrollView = MainScrollView.init(frame: self.view.bounds)
        self.view.addSubview(mainScrollView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
