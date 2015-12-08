//
//  FilterControl.m
//  XiaoKa
//
//  Created by 崔峰 on 15/4/29.
//  Copyright (c) 2015年 SmarterEye. All rights reserved.
//

#import "FilterControl.h"

#define LEFT_OFFSET 25
#define RIGHT_OFFSET 25
#define SELECTED_DISTANCE 5
#define COUNT 5
#define ROUND_RADIUS 2

@interface FilterControl (){
    float oneSlotSize;
    CGRect _rect;
}
@property (nonatomic, retain) UIColor *progressColor;
@property (nonatomic,retain) UIColor *tapedColor;
@end

@implementation FilterControl
@synthesize SelectedIndex, progressColor ,tapedColor;

-(id) initWithFrame:(CGRect) frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        
        SelectedIndex=0;
        progressColor=[UIColor clearColor];
        tapedColor=[UIColor whiteColor];
        CGPoint point = [self getCenterPointForIndex2:COUNT];
        oneSlotSize = 1.f*(point.x)/COUNT;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint centerPoint;
    int i;
    for (i = 0; i < COUNT; i++) {
        centerPoint = [self getCenterPointForIndex2:i];
        if (i + 1 == SelectedIndex) {
            CGContextSetFillColorWithColor(context, tapedColor.CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, progressColor.CGColor);
        }
        CGContextSetStrokeColorWithColor(context, tapedColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        if (i==0) {
            CGContextAddArc(context, centerPoint.x, rect.size.height / 2, 4, 0, 2*M_PI, 0);
        }
        if (i==1) {
            CGContextAddArc(context, centerPoint.x, rect.size.height / 2, 6, 0, 2*M_PI, 0);
        }
        if (i==2) {
            CGContextAddArc(context, centerPoint.x, rect.size.height / 2, 8, 0, 2*M_PI, 0);
        }
        if (i==3) {
            CGContextAddArc(context, centerPoint.x, rect.size.height / 2, 10, 0, 2*M_PI, 0);
        }
        if (i==4) {
            CGContextAddArc(context, centerPoint.x, rect.size.height / 2, 12, 0, 2*M_PI, 0);
        }
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

//获取绘制图形中心点
-(CGPoint )getCenterPointForIndex2:(int)j{
    CGFloat x = 0;
    CGFloat roundSpace = [self getRoundSpace];
    for (int i = 0; i < j; i++) {
        x = x + ROUND_RADIUS * 2 * (i + 2);
    }
    x = x +(j + 2) * ROUND_RADIUS + roundSpace * j + roundSpace;

    return CGPointMake(x, j==0?self.frame.size.height-55-SELECTED_DISTANCE:self.frame.size.height-55);
}

-(void) setSelectedIndex:(int)index{
    SelectedIndex = index;
    [self setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(selectedFilterIndex:)]) {
        [_delegate selectedFilterIndex:index];
    }
}

-(int)getSelectedInPoint:(CGPoint)point{
    CGFloat roundSpace = [self getRoundSpace];

    if (point.x < [self getCenterPointForIndex2:0].x + ROUND_RADIUS +roundSpace / 2  ) {
        return 1;
    }if ([self getCenterPointForIndex2:0].x + ROUND_RADIUS * 2 + roundSpace / 2  < point.x  && point.x < [self getCenterPointForIndex2:1].x + ROUND_RADIUS * 3 + roundSpace / 2 ) {
        return 2;
    }if ([self getCenterPointForIndex2:1].x + ROUND_RADIUS * 3 + roundSpace / 2  < point.x  && point.x < [self getCenterPointForIndex2:2].x + ROUND_RADIUS * 4 + roundSpace / 2 ) {
        return 3;
    }if ([self getCenterPointForIndex2:2].x + ROUND_RADIUS * 4 + roundSpace / 2  < point.x  && point.x < [self getCenterPointForIndex2:3].x + ROUND_RADIUS * 5 + roundSpace / 2 ) {
        return 4;
    }if ([self getCenterPointForIndex2:3].x + ROUND_RADIUS * 5 + roundSpace / 2  < point.x) {
        return 5;
    }
    
    return 0;
}
- (CGFloat)getRoundSpace{
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        return 12.0;
    }else if ([UIScreen mainScreen].bounds.size.width == 375){
        return 16.0;
    }else{
        return 22.0;
    }
}
-(void) ItemSelected: (UITapGestureRecognizer *) tap {
    SelectedIndex = [self getSelectedInPoint:[tap locationInView:self]];
    [self setSelectedIndex:SelectedIndex];
}

-(CGPoint)getCenterPointForIndex:(int) i{
    return CGPointMake((i/(float)(COUNT-1)) * (self.frame.size.width-RIGHT_OFFSET-LEFT_OFFSET) + LEFT_OFFSET, i==0?self.frame.size.height-55-SELECTED_DISTANCE:self.frame.size.height-55);
}

@end
