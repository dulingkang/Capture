//
//  CustumPhotoAlbum.swift
//  Capture
//
//  Created by dulingkang on 15/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit
import Photos

class CustomPhotoAlbum {
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    static let albumName = "爱拍美图"
    
    class var sharedInstance: CustomPhotoAlbum {
        struct Singleton {
            static let instance = CustomPhotoAlbum()
        }
        return Singleton.instance
    }
    
    init() {
        self.createAlbum()
    }
    
    private func createAlbum() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection : PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            self.albumFound = true
            assetCollection = collection.firstObject as! PHAssetCollection
        } else {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAlbumRequest : PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(CustomPhotoAlbum.albumName)
                self.assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                }, completionHandler: { success, error in
                    self.albumFound = (success ? true: false)
                    
                    if (success) {
                        let collectionFetchResult = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([self.assetCollectionPlaceholder.localIdentifier], options: nil)
                        print(collectionFetchResult)
                        self.assetCollection = collectionFetchResult.firstObject as! PHAssetCollection
                    }
            })
        }
    }
//    performChanges(changeBlock: dispatch_block_t, completionHandler: ((Bool, NSError?) -> Void)?)
    func saveImage(image: UIImage) {
        if self.assetCollection != nil {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                albumChangeRequest?.addAssets([assetPlaceholder!])
                }, completionHandler: {
                    success, error in
                    if error != nil {
                        print(error)
                    } else {
                        
                    }
            })
        }
    }
}

