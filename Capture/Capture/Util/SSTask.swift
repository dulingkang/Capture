
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
    
    var image: UIImage? {
        get {
            if self.image == nil {
                self.prepare()
            }
            let img = self.image!.copy()
            return img as? UIImage
        }
        set {
            
        }
    }
    
    private var imageFileName: String! {
        get {
            if self.imageFileName == nil {
               return self.generateFileName()
            }
            
        }
    }
    
    override init() {
        super.init()
        self.createPathIfNeeded()
    }
    
    //MARK: - public method
    func prepare() {
        self.image = self.loadImage()
    }
    
    func cache() {
        if self.imageFileName == nil {

        }
    }
    
    func clean() {
        
    }
    
    //MARK: - private method
    private func loadImage() -> UIImage? {
        let path = NSTemporaryDirectory() + "/" + kTaskCacheFolder + self.imageFileName
        let img = UIImage(contentsOfFile: path)
        return img
    }
    
    private func generateFileName() {
        let time = NSDate()
        return time
    }
    
    private func saveImage(img: UIImage) {
        let path = NSTemporaryDirectory() + "/" + kTaskCacheFolder + self.imageFileName
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            let data = UIImagePNGRepresentation(img)
            data?.writeToFile(path, atomically: true)
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
