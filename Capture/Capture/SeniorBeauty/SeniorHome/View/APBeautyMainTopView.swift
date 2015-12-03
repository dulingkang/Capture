//
//  APSeniorBeautyMainTopView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/25.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

protocol APBeautyMainTopViewDelegate {
    func backButtonPressed(sender: UIButton)
    func undoButtonPressed(sender: UIButton)
    func redoButtonPressed(sender: UIButton)
    func shareButtonPressed(sender: UIButton)
}

class APBeautyMainTopView: UIView {
    
    var undoButton: UIButton!
    var redoButton: UIButton!
    var apBeautyTopViewDelegate: APBeautyMainTopViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - event response
    func backButtonPressed(sender: UIButton) {
        self.apBeautyTopViewDelegate?.backButtonPressed(sender)
    }
    
    func undoButtonPressed(sender: UIButton) {
        self.apBeautyTopViewDelegate?.undoButtonPressed(sender)
    }
    
    func redoButtonPressed(sender: UIButton) {
        self.apBeautyTopViewDelegate?.redoButtonPressed(sender)
    }
    
    func shareButtonPressed(sender: UIButton) {
        self.apBeautyTopViewDelegate?.shareButtonPressed(sender)
    }
    
    
    //MARK: - private method
    private func initViews() {
        self.backgroundColor = UIColor.blackColor()
        self.addBackButton()
        self.addRedoButton()
        self.addUndoButton()
        self.addShareButton()
    }
    
    private func addBackButton() {
        let backButton = UIButton.init(frame: CGRectMake(0, 0, kButtonClickWidth, kButtonClickWidth))
        backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setImage(UIImage(named: "backNormal"), forState: UIControlState.Normal)
        backButton.setImage(UIImage(named: "backPress"), forState: UIControlState.Highlighted)
        self.addSubview(backButton)
    }
    
    private func addUndoButton() {
        self.undoButton = UIButton.init(frame: CGRectMake(kScreenWidth/2 - kButtonClickWidth - 5, 0, kButtonClickWidth, kButtonClickWidth))
        self.undoButton.addTarget(self, action: "undoButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.undoButton.setImage(UIImage(named: "undoNormal"), forState: UIControlState.Normal)
        self.undoButton.setImage(UIImage(named: "undoPress"), forState: UIControlState.Highlighted)
        self.undoButton.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.undoButton)
    }
    
    private func addRedoButton() {
        self.redoButton = UIButton.init(frame: CGRectMake(kScreenWidth/2 + 5, 0, kButtonClickWidth, kButtonClickWidth))
        self.redoButton.addTarget(self, action: "redoButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.redoButton.setImage(UIImage(named: "redoNormal"), forState: UIControlState.Normal)
        self.redoButton.setImage(UIImage(named: "redoPress"), forState: UIControlState.Highlighted)
        self.redoButton.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(self.redoButton)
    }
    
    private func addShareButton() {
        let shareButton = UIButton.init(frame: CGRectMake(kScreenWidth - kButtonClickWidth, 0, kButtonClickWidth, kButtonClickWidth))
        shareButton.addTarget(self, action: "shareButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        shareButton.setImage(UIImage(named: "shareNormal"), forState: UIControlState.Normal)
        shareButton.setImage(UIImage(named: "sharePress"), forState: UIControlState.Highlighted)
        self.addSubview(shareButton)
    }

}
