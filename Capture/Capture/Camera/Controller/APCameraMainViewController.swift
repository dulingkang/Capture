//
//  APCameraMainViewController.swift
//  Capture
//
//  Created by dulingkang on 8/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

class APCameraMainViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
}

extension APCameraFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kFilterCellWidth, kCameraFilterHeight)
    }
}