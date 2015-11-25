//
//  APBeautyMainMiddleView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APBeautyMainMiddleView: UIScrollView, UIScrollViewDelegate {

    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func initViews() {
        self.configScrollView()
        self.addImageView()
    }
    
    func configScrollView() {
        self.backgroundColor = UIColor.clearColor()
        self.delegate = self
        self.maximumZoomScale = 3
        self.minimumZoomScale = 1
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func addImageView() {
        
        self.imageView = UIImageView.init(frame: self.bounds)
        self.imageView.image = ImageModel.sharedInstance.rawImage
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.imageView.userInteractionEnabled = true
        self.addSubview(self.imageView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}
