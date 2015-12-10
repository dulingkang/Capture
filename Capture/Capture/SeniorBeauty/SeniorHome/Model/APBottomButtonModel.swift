//
//  APBottomButtonModel.swift
//  Capture
//
//  Created by ShawnDu on 15/11/26.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

struct APBottomButtonModel {
    
//    static let normalNameArray = ["editNormal", "filterNormal", "magicNormal", "frameNormal", "mosaicNormal", "ballonNormal", "textNormal"]
//    static let pressNameArray = ["editPressed", "filterPressed", "magicPressed", "framePressed", "mosaicPressed", "ballonPressed", "textPressed"]
//    static let buttonTitle = ["编辑", "滤镜", "魔棒", "相框", "模糊", "气泡", "文字"]
    static let normalNameArray = ["editNormal", "filterNormal", "magicNormal", "mosaicNormal", ]
    static let pressNameArray = ["editPressed", "filterPressed", "magicPressed", "mosaicPressed"]
    static let buttonTitle = ["编辑", "滤镜", "魔棒",  "模糊"]
    
}

enum APBottomButtonType: Int {
    case Edit = 0, Filter, Magic, Mosaic
}