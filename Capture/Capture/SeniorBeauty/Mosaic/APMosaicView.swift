//
//  APMosaicView.swift
//  Capture
//
//  Created by ShawnDu on 15/12/8.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

class APMosaicView: UIView {

    var previousTouchLocation: CGPoint = CGPointZero
    var currentTouchLocation:  CGPoint = CGPointZero
    var hideImage:    CGImageRef!
    var scratchImage: CGImageRef!
    var contextMask:  CGContextRef!
    
    var sizeBrush: CGFloat = 60.0 {
        
        didSet{
            CGContextSetLineWidth(contextMask, sizeBrush)
        }
        
    }
    var hideView:  UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    //MARK: CoreGraphics methods
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let imageToDraw = UIImage.init(CGImage: self.scratchImage)
        imageToDraw.drawInRect(self.bounds)
    }
    
    func setBrushSize(size: CGFloat){
        CGContextSetLineWidth(contextMask, size)
        
        
    }
    
    func getEndImg(image: UIImage) ->UIImage{
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func setHiddenView(hideView: UIView){
        
        let colorspace = CGColorSpaceCreateDeviceGray()
        
        let scale = UIScreen.mainScreen().scale
        
        UIGraphicsBeginImageContextWithOptions(hideView.bounds.size, false, 0)
        hideView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        hideView.layer.contentsScale = scale
        hideImage = UIGraphicsGetImageFromCurrentImageContext().CGImage
        UIGraphicsEndImageContext()
        
        let imageWidth = CGImageGetWidth(hideImage)
        let imageHeight = CGImageGetHeight(hideImage)
        
        let pixels = CFDataCreateMutable(nil, imageWidth * imageHeight);
        contextMask = CGBitmapContextCreate(CFDataGetMutableBytePtr(pixels), imageWidth, imageHeight , 8, imageWidth, colorspace, CGImageAlphaInfo.None.rawValue)
        let dataProvider = CGDataProviderCreateWithCFData(pixels)
        
        CGContextSetFillColorWithColor(contextMask, UIColor.blackColor().CGColor)
        CGContextFillRect(contextMask, self.frame)
        
        CGContextSetStrokeColorWithColor(contextMask, UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(contextMask, 2000)
        
        CGContextSetLineCap(contextMask, CGLineCap.Round)
        
        let mask = CGImageMaskCreate(imageWidth, imageHeight, 8, 8, imageWidth, dataProvider, nil, false);
        scratchImage = CGImageCreateWithMask(hideImage, mask)
        
        self.hideImageView()
        
    }
    
    func setPathColor(fillColor: UIColor, strokeColor: UIColor){
        CGContextSetLineWidth(contextMask, self.sizeBrush)
        
        CGContextSetFillColorWithColor(contextMask, fillColor.CGColor)
        
        CGContextSetStrokeColorWithColor(contextMask, strokeColor.CGColor)
    }
    
    func hideImageView(){
        
        CGContextMoveToPoint(contextMask, 0,0)
        CGContextAddLineToPoint(contextMask, self.bounds.width, self.bounds.height)
        CGContextStrokePath(contextMask);
        self.setNeedsDisplay()
        
    }
    
    func scratchTheViewFrom(startPoint: CGPoint, endPoint: CGPoint){
        
        let scale = UIScreen.mainScreen().scale;
        
        CGContextMoveToPoint(contextMask, startPoint.x * scale, (self.frame.size.height - startPoint.y) * scale)
        CGContextAddLineToPoint(contextMask, endPoint.x * scale, (self.frame.size.height - endPoint.y) * scale)
        CGContextStrokePath(contextMask);
        self.setNeedsDisplay()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch : UITouch =  (event?.touchesForView(self)?.first)!
        self.currentTouchLocation = touch.locationInView(self)
        print("\(self.currentTouchLocation)")
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch = event!.touchesForView(self)?.first
        if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero))
        {
            currentTouchLocation = touch!.locationInView(self)
        }
        
        previousTouchLocation = touch!.previousLocationInView(self)
        self.scratchTheViewFrom(previousTouchLocation, endPoint: currentTouchLocation)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch = event!.touchesForView(self)?.first
        
        if (!CGPointEqualToPoint(previousTouchLocation, CGPointZero))
        {
            previousTouchLocation = touch!.previousLocationInView(self)
            self.scratchTheViewFrom(previousTouchLocation, endPoint: currentTouchLocation)
            
        }
        
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
    }
    //MARK: touch event
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
