//
//  FilterControl.h
//  XiaoKa
//
//  Created by 崔峰 on 15/4/29.
//  Copyright (c) 2015年 SmarterEye. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterControlDelegate <NSObject>

- (void)selectedFilterIndex:(NSInteger)index;
@end

@interface FilterControl : UIControl

-(id)initWithFrame:(CGRect) frame;

@property (nonatomic, readonly) NSInteger selectedIndex;
@property (nonatomic, weak)id <FilterControlDelegate> delegate;

@end
