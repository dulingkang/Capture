
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
// 屏幕的物理高度
let kScreenHeight = UIScreen.mainScreen().bounds.size.height

 // 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0 }

// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
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
let kFilterStartTag : UInt = 2000

enum Filter:UInt {
    case None = 2000, ZiRan, TianMi, WeiMei, DianYa,FenNen, LuoKeKe, ABaoSe, QingLiang, FuGu, HuaiJiu, HeiBai, RouGuang
}

//camera view
let kWidthRatio = kScreenWidth/320
let kCameraFilterHeight: CGFloat = 65
let kCameraBottomHeight: CGFloat = 88 * kWidthRatio


