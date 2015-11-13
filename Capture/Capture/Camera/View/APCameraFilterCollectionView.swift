//
//  APCameraFilterCollectionView.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

protocol APCameraFilterDelegate {
    func switchFilter(index: Int)
}

class APCameraFilterCollectionCell: UICollectionViewCell {
    var filterImageView: UIImageView!
    var filterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let filterImage = UIImage(named: "filter0")
        self.filterImageView = UIImageView.init(frame: CGRectMake(0, 0, kFilterCellWidth, kFilterCellImageHeight))
        self.filterImageView.image = filterImage
        self.addSubview(filterImageView)
        
        filterLabel = UILabel.init(frame: CGRectMake(0, kFilterCellImageHeight, kFilterCellWidth, kFilterCellLabelHeight))
        filterLabel.font = UIFont.systemFontOfSize(12)
        filterLabel.textColor = UIColor.whiteColor()
        filterLabel.textAlignment = NSTextAlignment.Center
        filterLabel.layer.shadowRadius = 2
        filterLabel.layer.shadowColor = UIColor.blackColor().CGColor
        filterLabel.layer.shadowOffset = CGSizeMake(0, 3)
        filterLabel.layer.shadowOpacity = 0.9
        self.addSubview(filterLabel)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
}

class APCameraFilterCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var filterCollectionDelegate: APCameraFilterDelegate?
    var filterModel: FilterModel!
    var picNameArray: NSMutableArray!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.config()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: UICollectionView datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picNameArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "filterCollectionCell"
        collectionView.registerClass(APCameraFilterCollectionCell.self, forCellWithReuseIdentifier: identifier)
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as? APCameraFilterCollectionCell
        if cell == nil {
            cell = APCameraFilterCollectionCell()
        }
        while (cell!.contentView.subviews.last != nil) {
            let tmpView: UIView = (cell!.contentView.subviews.last)!
            tmpView.removeFromSuperview()
        }

        cell!.filterImageView.image = UIImage(named: self.picNameArray[indexPath.row] as! String)
        cell!.filterLabel.text = self.filterModel.filterList[indexPath.row].title
        cell!.layer.borderWidth = 0
        
        return cell!
    }

    //MARK: UICollectionView delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let visibleCells = self.visibleCells() 
        for oneCell in visibleCells {
            oneCell.layer.borderWidth = 0
        }
        
        let cell = self.cellForItemAtIndexPath(indexPath)
        cell!.layer.borderColor = UIColor.orangeColor().CGColor
        cell!.layer.borderWidth = 2
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        self.filterCollectionDelegate?.switchFilter(indexPath.row)
    }
    
    //MARK: private method
    func config() {
        self.filterModel = FilterModel.sharedInstance
        self.picNameArray = NSMutableArray.init(capacity: self.filterModel.filterList.count)
        for (var index = 0; index < self.filterModel.filterList.count; index++) {
            self.picNameArray.addObject(self.filterModel.filterList[index].imageTilte)
        }
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.clearColor()
    }

}

