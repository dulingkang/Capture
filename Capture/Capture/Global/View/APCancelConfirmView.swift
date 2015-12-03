//
//  APCancelConfirmView.swift
//  Capture
//
//  Created by ShawnDu on 15/11/26.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

protocol APCancelConfirmViewDelegate {
    func cancelButtonPressed()
    func confirmButtonPressed()
}

class APCancelConfirmView: UIView {

    var delegate: APCancelConfirmViewDelegate?
    var titleLabel: UILabel!
    let kLabelWidth: CGFloat = 200
    var title = "" {
        didSet {
            self.updateLabelFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    private func initViews() {
        self.backgroundColor = UIColor.clearColor()
        self.addCancelButton()
        self.addConfirmButton()
        self.addTitleLabel()
    }
    
    //MARK: - event response
    func cancelButtonPressed(sender: UIButton) {
        self.delegate?.cancelButtonPressed()
    }
    
    func confirmButtonPressed(sender: UIButton) {
        self.delegate?.confirmButtonPressed()
    }
    
    //MARK: - private method
    private func addCancelButton() {
        let cancelButton = UIButton.init(frame: CGRectMake(0, 0, kButtonClickWidth, kButtonClickWidth))
        cancelButton.setImage(UIImage(named: "cancelNormal"), forState: UIControlState.Normal)
        cancelButton.setImage(UIImage(named: "cancelPress"), forState: UIControlState.Highlighted)
        cancelButton.addTarget(self, action: "cancelButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(cancelButton)
    }
    
    private func addConfirmButton() {
        let confirmButton = UIButton.init(frame: CGRectMake(self.width - kButtonClickWidth, 0, kButtonClickWidth, kButtonClickWidth))
        confirmButton.setImage(UIImage(named: "confirmNormal"), forState: UIControlState.Normal)
        confirmButton.setImage(UIImage(named: "confirmPress"), forState: UIControlState.Highlighted)
        confirmButton.addTarget(self, action: "confirmButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(confirmButton)
    }
    
    private func addTitleLabel() {
        self.titleLabel = UILabel.init()
        self.titleLabel.font = UIFont.systemFontOfSize(12)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(self.titleLabel)
        self.updateLabelFrame()
    }
    
    private func updateLabelFrame() {
        self.titleLabel.text = self.title
        let rect = self.titleLabel.textRectForBounds(CGRectMake((kScreenWidth - kLabelWidth)/2, 0, kLabelWidth, self.height), limitedToNumberOfLines: 1)
        self.titleLabel.frame = CGRectMake((kScreenWidth - rect.size.width)/2, (self.height - rect.size.height)/2, rect.size.width, rect.size.height)
    }
}
