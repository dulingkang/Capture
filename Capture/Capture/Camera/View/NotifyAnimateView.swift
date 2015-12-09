//
//  NotifyAnimateView.swift
//  XiaoKa
//
//  Created by ShawnDu on 15/11/11.
//  Copyright © 2015年 SmarterEye. All rights reserved.
//

import UIKit

class NotifyAnimateView: NSObject {
    
    var label: UILabel!
    let kScreenWidth = UIScreen.mainScreen().bounds.size.width
    let kScreenHeight = UIScreen.mainScreen().bounds.size.height
    var labelWidth: CGFloat!
    var labelHeight: CGFloat = 30
    
    static let sharedInstance = NotifyAnimateView()
    override init() {
        super.init()
        labelWidth = kScreenWidth * 0.4
        label = UILabel.init()
        let currentWindow = UIApplication.sharedApplication().keyWindow
        currentWindow!.addSubview(self.label)
    }

    func showNotify(string: String) {
        label.text = string
        label.font = UIFont.systemFontOfSize(20)
//        let attributes = [NSFontAttributeName: label.font]
//        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
//        let text: NSString = NSString(CString:label.text!.cStringUsingEncoding(NSUTF8StringEncoding)!,
//            encoding: NSUTF8StringEncoding)!
//        let rect = text.boundingRectWithSize(CGSizeMake(labelWidth, labelHeight), options: option, attributes: attributes, context: nil)
        self.label.textColor = UIColor.blackColor()
        self.label.alpha = 0.2
//        labelWidth = rect.size.width
//        labelHeight = rect.size.height
        self.label.textAlignment = NSTextAlignment.Center
//        self.label.layer.shadowRadius = 3
//        self.label.layer.shadowColor = UIColor.blackColor().CGColor
//        self.label.layer.shadowOffset = CGSizeMake(0, 5)
//        self.label.layer.shadowOpacity = 0.9
        self.label.frame = CGRectMake((kScreenWidth - labelWidth)/2, kScreenHeight/9, labelWidth, labelHeight)
        self.addAnimation()
    }
    
    func addAnimation() {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            let transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.label.transform = transform
            
            }, completion: {
                finished in
                UIView.animateWithDuration(0.8, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    let transform = CGAffineTransformMakeScale(0.8, 0.8)
                    self.label.transform = transform
                    self.label.alpha = 0.0
                    }, completion: {
                        finished in
                })
        })
    }

}
