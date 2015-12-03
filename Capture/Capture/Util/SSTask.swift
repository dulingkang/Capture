
//
//  SSTask.swift
//  Capture
//
//  Created by ShawnDu on 15/11/24.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

let kTaskCacheFolder = "TaskCacheFolder"

class SSTask: NSObject {
    
    var image: UIImage?
    private var imageFileName: String?

    override init() {
        super.init()
        self.createPathIfNeeded()
    }
    
    static func emptyDirectory() {
        let fileManager = NSFileManager.defaultManager()
        let folderPath = NSTemporaryDirectory() + "/" + kTaskCacheFolder
        
        if let files = fileManager.subpathsAtPath(folderPath) {
            for fileName in files {
                let fullPath = folderPath + fileName
                do {
                    try fileManager.removeItemAtPath(fullPath)
                } catch {
                }
            }
        }

    }

    //MARK: - public method
    func prepare() {
        self.image = self.loadImage()
    }
    
    func cache() {
        self.saveImage(self.image!)
        self.image = nil
    }
    
    func clean() {
        self.deleteImage()
        self.image = nil
        self.imageFileName = nil
    }
    
    //MARK: - private method
    private func loadImage() -> UIImage? {
        
        if self.imageFileName == nil {
            self.imageFileName = self.generateFileName()
        }
        
        let path = NSTemporaryDirectory() + "/" + kTaskCacheFolder + self.imageFileName!
        let img = UIImage(contentsOfFile: path)
        return img
    }
    
    private func generateFileName() -> String {
        let time = NSDate().timeIntervalSince1970
        let timeStr = String(time)
        return timeStr
    }
    
    private func saveImage(img: UIImage) {
        if self.imageFileName == nil {
            self.imageFileName = self.generateFileName()
        }
        let path = NSTemporaryDirectory() + "/" + kTaskCacheFolder + self.imageFileName!
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            let data = UIImagePNGRepresentation(img)
            data?.writeToFile(path, atomically: true)
        }
    }
    
    private func deleteImage() {
        let path = NSTemporaryDirectory() + "/" + kTaskCacheFolder + self.imageFileName!
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(path)
            } catch {
                print("SSTask file manager remove item failed")
            }
        }
    }
    
    private func createPathIfNeeded() {
        let tmpPath = NSTemporaryDirectory()
        let folderPath = tmpPath + "/" + kTaskCacheFolder
        if !NSFileManager.defaultManager().fileExistsAtPath(folderPath) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("SSTask create cache folder failed!")
            }
            
        }
    }
}
