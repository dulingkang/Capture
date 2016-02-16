
//
//  GlobalDef.swift
//  Capture
//
//  Created by ShawnDu on 15/11/6.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//
import UIKit
import Foundation

let kScreenWidth = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
let kIphone4sHeight: CGFloat = 480
let kIphone4sWidth: CGFloat = 320
let kNavigationHeight: CGFloat = 44
let kButtonClickWidth: CGFloat = 40
 // 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0 }

// App沙盒路径
func kAppPath() -> String! {
    return NSHomeDirectory()
}
// Documents路径
func kBundleDocumentPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
}

//Cache
func kCachesPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
}

//GDT ads key
let kGDTAdsId = "1104867941"
let kGDTFlashId = "6020306615865589"
let kGDTInsertId = "3040203665567508"
let kGDTBannerId = "8010104645161507"
let kGDTInsertBigId = "5040003615571116"

//Baidu ads key
let kBaiduAdsId = "e2864f4e"

//umeng key
let kUmengAppKey = "5596966d67e58eb0af00044f"
let kSinaWBKey = "356086632"
let kSinaWBSecret = "7948b0f39962cca0e1f1b5a619168892"
let kWxKey = "wx00dc48cb33ac64f0"
let kWxSecrect = "cd407f6d448aee18e0722115dda8ae1a"
let kQQKey = "1104634700"
let kQQSecrect = "f65svfysCOEceXtk"

//appstore url
let kAppStoreAiPaiURL = "https://appsto.re/cn/ti6t7.i"

//camera filter
let kFilterNone = "原图"
let kFilterZiRan = "自然"
let kFilterTianMi = "甜美可人"
let kFilterWeiMei = "唯美"
let kFilterDianYa = "典雅"
let kFilterFenNen = "粉嫩"
let kFilterLuoKeKe = "洛可可"
let kFilterABaoSe = "阿宝色"
let kFilterQingLiang = "清凉"
let kFilterFuGu = "复古"
let kFilterHuaiJiu = "怀旧"
let kFilterHeiBai = "黑白"
let kFilterRouGuang = "柔光"
let kFilterStartTag : UInt = 10000

enum Filter: UInt {
    case None = 10000, ZiRan, TianMi, WeiMei, DianYa,FenNen, LuoKeKe, ABaoSe, QingLiang, FuGu, HuaiJiu, HeiBai, RouGuang
}

//camera view
let kWidthRatio = kScreenWidth/320
let kCameraFilterHeight: CGFloat = 75
let kCameraBottomHeight: CGFloat = kScreenHeight - kNavigationHeight - kScreenWidth*4/3
let kCameraBottom4SHeight: CGFloat = 70
let kFilterCellWidth: CGFloat = 60
let kFilterCellImageHeight: CGFloat = 57
let kFilterCellLabelHeight: CGFloat = 20
let kCameraViewTopButtonStartTag: Int = 11000

//beauty main view
let kBeautyMainBottomHeight: CGFloat = 50
let kBeautyMainBottomButtonStartTag: Int = 11020


//MARK: Used Tag
/*
10000 - 10999             CamerFilter
11000 - 11019             CameraViewTopButton
11020 - 11029             BeautyMainBottomButton
11030 - 11059             APShowItemScrollView
*/
