//
//  APCameraManager.swift
//  Capture
//
//  Created by dulingkang on 12/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit
import GPUImage

protocol APCameraManagerDelegate {
    
}

class APCameraManager: GPUImageStillCamera {
    
    var cameraManagerDelegate: APCameraManagerDelegate?
    
    init(preset: String, cameraPosition: AVCaptureDevicePosition) {
        super.init(sessionPreset: preset, cameraPosition: cameraPosition)
        self.horizontallyMirrorRearFacingCamera = true
    }
}
