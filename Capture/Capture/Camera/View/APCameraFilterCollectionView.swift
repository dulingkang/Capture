//
//  APCameraFilterCollectionView.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

protocol APCameraFilterDelegate {
    func switchFilter(index: NSInteger)
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
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        while (cell.contentView.subviews.last != nil) {
            let tmpView: UIView = (cell.contentView.subviews.last)!
            tmpView.removeFromSuperview()
        }
        let imageView = UIImageView.init(frame: CGRectMake(0, cell.dHeight*0.2, cell.dWidth, cell.dHeight*0.8))
        imageView.image = UIImage(named: self.picNameArray[indexPath.row] as! String)
        cell.contentView.addSubview(imageView)
        let textLabel = UILabel.init(frame: CGRectMake(0, 0, cell.dWidth, cell.dHeight*0.2))
        textLabel.text = self.filterModel.filterList[indexPath.row].title
        textLabel.font = UIFont.systemFontOfSize(12)
        textLabel.textAlignment = NSTextAlignment.Center
        cell.contentView.addSubview(textLabel)
        cell.backgroundColor = UIColor.orangeColor()
        cell.layer.borderWidth = 0
        
        return cell
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
        self.backgroundColor = UIColor.clearColor()
    }

}

