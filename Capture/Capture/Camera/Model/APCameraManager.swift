//
//  APCameraManager.swift
//  Capture
//
//  Created by dulingkang on 12/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

protocol APCameraManagerDelegate {
    
}

class APCameraManager: GPUImageStillCamera {
    
    var cameraManagerDelegate: APCameraManagerDelegate?
    
    override init(sessionPreset: String, cameraPosition: AVCaptureDevicePosition) {
        super.init(sessionPreset: <#T##String!#>, cameraPosition: <#T##AVCaptureDevicePosition#>)
        super.init(sessionPreset: sessionPreset,cameraPosition: cameraPosition)
        
    }
}
