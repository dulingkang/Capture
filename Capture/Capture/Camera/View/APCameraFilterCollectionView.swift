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
    var currentIndexPath: NSIndexPath?
    
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
        currentIndexPath = indexPath;
        self.changeSelectedStates()
    
        var visiblePathArray = self.indexPathsForVisibleItems()
        visiblePathArray = visiblePathArray.sort({$0.row < $1.row})
        
        var needScrollToCenterIndexPath: NSIndexPath!
        if (indexPath.row == visiblePathArray.first?.row) {
            needScrollToCenterIndexPath = visiblePathArray[visiblePathArray.count - 2]
             self.scrollToItemAtIndexPath(needScrollToCenterIndexPath, atScrollPosition: .Right, animated: true)
        } else if (indexPath.row == visiblePathArray.last?.row) {
            needScrollToCenterIndexPath = visiblePathArray[1]
            self.scrollToItemAtIndexPath(needScrollToCenterIndexPath, atScrollPosition: .Left, animated: true)
        }
        let notifyAnimate = NotifyAnimateView.sharedInstance
        notifyAnimate.showNotify(filterModel.filterList[indexPath.row].title)
        self.filterCollectionDelegate?.switchFilter(indexPath.row)
    }
    
    //MARK: - public method
    func didSelectCollectionCell(index: Int) {
        currentIndexPath = NSIndexPath.init(forRow: index, inSection: 0)
        self.scrollToItemAtIndexPath(currentIndexPath!, atScrollPosition: .CenteredHorizontally, animated: true)
        self.performSelector("changeSelectedStates", withObject: nil, afterDelay: 0.3)
    }
    
    func filterCellScrollToLeft(isFromRightToLeft: Bool) {
        if currentIndexPath == nil {
            currentIndexPath = NSIndexPath.init(forRow: 0, inSection: 0)
        }
        var row: Int = 0
        if isFromRightToLeft {
            row = currentIndexPath!.row + 1
        } else {
            row = currentIndexPath!.row - 1
        }
        row = row < 0 ? 0 : row
        row = row > picNameArray.count - 1 ? picNameArray.count - 1 : row
        currentIndexPath = NSIndexPath.init(forRow: row, inSection: 0)
        self.collectionView(self, didSelectItemAtIndexPath: currentIndexPath!)
    }
    
    //MARK: - private method
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
    
    private func changeSelectedStates() {
        for cell in self.visibleCells() {
            cell.layer.borderWidth = 0
        }
        let currentCell = self.cellForItemAtIndexPath(currentIndexPath!)
        currentCell?.layer.borderWidth = 1
        currentCell?.layer.borderColor = UIColor.orangeColor().CGColor
    }

}

