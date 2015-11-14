//
//  GPUImageCustomLookupFilter.swift
//  Capture
//
//  Created by ShawnDu on 15/11/13.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//
import GPUImage

class GPUImageCustomLookupFilter: GPUImageFilterGroup {

    var lookupImageSource: GPUImagePicture?
    init(lookupImageName: String) {
        super.init()
        let image = UIImage(named: lookupImageName)
        self.lookupImageSource = GPUImagePicture.init(image: image)
        let lookupFilter = GPUImageLookupFilter.init()
        self.addTarget(lookupFilter)
        self.lookupImageSource?.addTarget(lookupFilter, atTextureLocation: 1)
        self.lookupImageSource?.processImage()
        self.initialFilters = [lookupFilter]
        self.terminalFilter = lookupFilter
    }
}
