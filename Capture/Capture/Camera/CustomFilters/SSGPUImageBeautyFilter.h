//
//  SSGPUImageBeautyFilter.h
//  Capture
//
//  Created by ShawnDu on 16/6/3.
//  Copyright © 2016年 ShawnDu. All rights reserved.
//
#import <GPUImage/GPUImage.h>

@class GPUImageCombinationFilter;
@interface SSGPUImageBeautyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;           //face
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;  //edge
    GPUImageCombinationFilter *combinationFilter;       //combine
    GPUImageHSBFilter *hsbFilter;                       //HSB
}

@end
