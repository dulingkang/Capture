//
//  FilterModel.swift
//  XiaoKa
//
//  Created by ShawnDu on 15/10/20.
//  Copyright © 2015年 SmarterEye. All rights reserved.
//

import UIKit

class FilterItem: NSObject {
    var category: UInt = 0
    var title: String = ""
    var imageTilte: String = ""
    
    init(category: UInt, title: String, imageTitle: String) {
        super.init()
        self.category = category
        self.title = title
        self.imageTilte = imageTitle
    }
}

class FilterModel: NSObject {
    var filterList: [FilterItem] = []
    
    class var sharedInstance: FilterModel {
        struct Singleton {
            static let instance = FilterModel()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        initFilterList()
    }

    private func initFilterList() {
        let filterTitleArray = [
            kFilterNone,
            kFilterZiRan,
            kFilterTianMi,
            kFilterQingLiang,
            kFilterFenNen,
            kFilterFuGu,
            kFilterRouGuang,
            kFilterWeiMei,
            kFilterHeiBai,
            kFilterABaoSe,
            kFilterHuaiJiu,
            kFilterDianYa,
            kFilterLuoKeKe
            ]

//        let imageNameArray = [
//        "effects_00_meiyan", "effects_03_ziran", "effects_01_tianmei", "effects_06_qingliang", "effects_05_fennen", "effects_07_fugu", "effects_08_rouguang", "effects_10_weimei", "effects_04_heibai", "effects_09_abaose", "effects_11_huaijiu", "effects_12_dianya", "effects_13_keke"]
    
        for i in 0 ..< filterTitleArray.count {
//            let imageStr = String(format: "%@%d", "filter", i)
            let imageStr = "filter0.jpg"
//            let imageStr = imageNameArray[i]
            let item = FilterItem(category: (kFilterStartTag + UInt(i)), title: filterTitleArray[i], imageTitle: imageStr)
            self.filterList.append(item)
        }
    }
}
