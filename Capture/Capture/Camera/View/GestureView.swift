//
//  GestureView.swift
//  XiaoKa
//
//  Created by ShawnDu on 15/11/10.
//  Copyright © 2015年 SmarterEye. All rights reserved.
//

import UIKit

protocol GestureViewControl {
    func leftSwipe()
    func rightSwipe()
}

class GestureView: UIView, UIGestureRecognizerDelegate {
    
    var gestureControl: GestureViewControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addGestures()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    // MARK: Gesture actions
//    func tapPressed(tap: UITapGestureRecognizer) {
//    
//        self.gestureControl?.tapScreen()
//    }
    
    func leftSwipe(swipe: UISwipeGestureRecognizer) {

        self.gestureControl?.leftSwipe()
    }
    
    func rightSwipe(swipe: UISwipeGestureRecognizer) {
        
        self.gestureControl?.rightSwipe()
    }
    
    //MARK: Private method
    func addGestures() {
//        let tap = UITapGestureRecognizer.init(target: self, action: "tapPressed:")
//        self.addGestureRecognizer(tap)
        
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: "leftSwipe:")
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: "rightSwipe:")
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(rightSwipe)
    }
}






