//
//  PaintingView.m
//  Aico
//
//  Created by jiang liyin on 12-05-09.
//  Copyright 2011 cienet. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PaintingView.h"
#import "CGPointExtension.h"
#import "UIImage+extend.h"


@implementation PaintingView
@synthesize operationArray = operationArray_;
@synthesize stampPicName = stampPicName_;
@synthesize imageSize = imageSize_;
@synthesize touchEndTimer = touchEndTimer_;

#define kTimerWaitTime     1  //手指离开屏幕，等待时间


/**
 * @brief 
 * 对象初始化
 *
 * @param [in]
 * @param [out]
 * @return 
 * @note
 */
- (id)initWithFrame:(CGRect)frame 
{    
    self = [super initWithFrame:frame];
    if (self) 
	{
		operationArray_ = [[NSMutableArray alloc]initWithCapacity:0];
        imageSize_ = 70;
        self.clipsToBounds = YES;		
    }
    return self;
}


/**
 * @brief 
 * 给每个点添加calayer，用动画显示
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)addAnimationLayerWithImageName:(UIImage *)image atPoint:(CGPoint)point
{
    
    CALayer *layer = [[CALayer alloc] init];
    layer.contents = (id)[image CGImage];
    layer.position = point;
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.bounds = CGRectMake(0, 0, layerSize_.width, layerSize_.height);
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8f, 0.8f, 1.0f)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.1f)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    
    animation.values = values;
    animation.duration = 0.1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:@"transform"];
    layer.opacity = 0.9;
    CALayer *superLayer = [[self.layer sublayers] lastObject];
    [superLayer addSublayer:layer];
}
#pragma mark -
#pragma mark Drawing Operation
/**
 * @brief 
 * 获取每个点处将要绘制的图片
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (UIImage *)getImageAtEachPoint
{
//    int index = 1;
//    //curpoint处需要画的随机图片名
//    NSString *picName = [NSString stringWithFormat:@"%@_%d.png",self.stampPicName,index];
    
    NSInteger index = 30 + (arc4random()%(100 + 1 - 30 + 1));
    UIImage *curImage = [UIImage imageNamed:self.stampPicName];
    layerSize_ = CGSizeMake(index, index);
    imageSize_ = ccpDistance(CGPointMake(0, 0), CGPointMake(index, index));
    
    //curpoint处需要画的图片旋转角度
    curImage = [curImage imageRotatedByDegrees:[self getRandomNumber:0 to:35] * 10];
    return curImage;
    return nil;
}

- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return from + (arc4random()%(to + 1 - from + 1));
}

/**
 * @brief 
 * 更新撤销和恢复图片
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)updateUndoAndRedo
{
//    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
//    //是否可以进行撤销操作,[self.layer sublayers]中包含了imageview的layer，所以－1
//    if ([[self.layer sublayers] count] - 1 > 0)
//    {
//        [tempArray addObject:[NSNumber numberWithBool:YES]];
//    }
//    else
//    {
//        [tempArray addObject:[NSNumber numberWithBool:NO]];
//    }
//    
//    //是否可以进行恢复操作
//    if ([operationArray_ count] > 0)
//    {
//        [tempArray addObject:[NSNumber numberWithBool:YES]];
//    }
//    else
//    {
//        [tempArray addObject:[NSNumber numberWithBool:NO]];
//    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBtnImage" object:tempArray];

}

/**
 * @brief 
 * 更新ReUnManager  snapimage
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
//- (void)updateImageSnap
//{
//    UIImage *image = [self getCurrentPic];
//    if (image)
//    {
//        [[ReUnManager sharedReUnManager] storeSnap:image];
//        [[ReUnManager sharedReUnManager] saveMagicWandView];
//    }
//}

/**
 * @brief 
 * 绘制每个点
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)drawImageAtPoint:(CGPoint)point
{
    //随机选择图片，大小，方向
    UIImage *curImage = [self getImageAtEachPoint];
    //创建layer，用缩放动画显示
    [self addAnimationLayerWithImageName:curImage atPoint:point];

    lastPoint_ = point;
}

-(void)setLastLayerOpacity
{
    CALayer *layer = [[self.layer sublayers] lastObject];
    layer.opacity = 1.0f;
    for (CALayer *layerObj in [layer sublayers])
    {
        layerObj.opacity = 1.0f;
    }
    
    self.touchEndTimer = nil;
    //更新undo，redo按钮图片
    [self updateUndoAndRedo];
}
/**
 * @brief 
 * 触摸事件开始
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (operationArray_ && [operationArray_ count] > 0)
    {
        [operationArray_ removeAllObjects];
        [self updateUndoAndRedo];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInteractionEnable" object:[NSNumber numberWithBool:NO]];
    UITouch *touch = [touches anyObject];	
    CGPoint curPoint = [touch locationInView:self];
    
    if (self.touchEndTimer && [self.touchEndTimer isValid])
    {
        [self.touchEndTimer invalidate];
        self.touchEndTimer = nil;
        //如果定时器仍有效，则表明上一个touchend结束后还没有达到1s，那么现在的这个touch还要绘制在上一个layer上,所以什么都不用做，只用绘制图片
    }
    else
    {
        //每个笔画开始时，创建一个图层，然后该笔画的所有点会绘制到该图层
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = self.bounds;
        [self.layer addSublayer:layer];
    }
    [self drawImageAtPoint:curPoint];
    lastImageSize_ = imageSize_;

}

/**
 * @brief 
 * 触摸事件
 *
 * @param [in]
 * @param [out]
 * @return 
 * @note
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];	
    CGPoint curPoint = [touch locationInView:self];
    UIImage *curImage = [self getImageAtEachPoint];
    if (ccpDistance(lastPoint_, curPoint) > (imageSize_ /2.0 + lastImageSize_/2.0 - 3) &&  ccpDistance(lastPoint_, curPoint) < (imageSize_ /2.0 + lastImageSize_/2.0 + 3))
    {
        lastImageSize_ = imageSize_;
        //创建layer，用缩放动画显示
        [self addAnimationLayerWithImageName:curImage atPoint:curPoint];
        
        lastPoint_ = curPoint;    }
    else if(ccpDistance(lastPoint_, curPoint) > (imageSize_ /2.0 + lastImageSize_/2.0+ 3))
    {
        while (ccpDistance(lastPoint_, curPoint) > imageSize_ /2.0 + lastImageSize_/2.0 + 3)
        {
            
            double disLength = ccpDistance(lastPoint_, curPoint);
            double x = (curPoint.x - lastPoint_.x) * (imageSize_ /2.0 + lastImageSize_/2.0) / disLength;
            double y = (curPoint.y - lastPoint_.y) * (imageSize_ /2.0 + lastImageSize_/2.0) / disLength;
            
            CGPoint makePoint = CGPointMake(lastPoint_.x + x, lastPoint_.y + y);
            lastImageSize_ = imageSize_;
//            [self drawImageAtPoint:makePoint];
            //创建layer，用缩放动画显示
            [self addAnimationLayerWithImageName:curImage atPoint:makePoint];
            lastPoint_ = makePoint;
            curImage = [self getImageAtEachPoint];
            
        }

    }

}

/**
 * @brief 
 * 触摸事件结束
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	UITouch *touch = [touches anyObject];	
    CGPoint curPoint = [touch locationInView:self];
    UIImage *curImage = [self getImageAtEachPoint];
    if (ccpDistance(lastPoint_, curPoint) > (imageSize_/2.0 + lastImageSize_/2.0))
    {
        NSLog(@"ignore");
    }
    else if(ccpDistance(lastPoint_, curPoint) > (imageSize_/2.0 + lastImageSize_/2.0) /2)
    {
//        [self drawImageAtPoint:curPoint];
        lastImageSize_ = imageSize_;
        //创建layer，用缩放动画显示
        [self addAnimationLayerWithImageName:curImage atPoint:curPoint];
        
        lastPoint_ = curPoint;
    }
    
    //启动定时器，当手指离开屏幕时间超过1s时，刚刚画的图层的所有子图层由半透明变为不透明，未超过1s用户接着画时，所画的图片在之前的图层上继续画
    self.touchEndTimer = [NSTimer scheduledTimerWithTimeInterval:kTimerWaitTime target:self selector:@selector(setLastLayerOpacity) userInfo:nil repeats:NO];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInteractionEnable" object:[NSNumber numberWithBool:YES]];
	
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInteractionEnable" object:[NSNumber numberWithBool:YES]];
}

#pragma mark -
#pragma mark Picture Operation
/**
 * @brief 
 * 截取当前绘画视图
 *
 * @param [in]
 * @param [out]
 * @return 截取的图片
 * @note
 */
- (UIImage *)getCurrentPic
{
    if ([[self.layer sublayers] count]-1 == 0)
    {
        return nil;
    }
    
	UIImage *currentImage = nil;
    UIImage *image = nil;
//    [[ReUnManager sharedReUnManager] getGlobalSrcImage];
    
    if (image.size.width<=150 && image.size.height<=150)
    {
        UIGraphicsBeginImageContext(self.bounds.size);
    }
    else
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, image.size.width/self.bounds.size.width) ;
    }

	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	currentImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return currentImage;
}
/**
 * @brief 
 * 撤销操作
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)backwardDrawing
{
    //[self.layer sublayers]中包含了imageview的layer，所以－1
	if([[self.layer sublayers] count] - 1 == 0)
	{
		return;
	}
	[operationArray_  addObject:[[self.layer sublayers] lastObject] ];
    
    CALayer *layer = [[self.layer sublayers] lastObject];
    [layer removeFromSuperlayer];

    [self updateUndoAndRedo];
}
/**
 * @brief 
 * 恢复操作
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)forwardDrawing
{
	if([operationArray_ count] == 0)
	{
		return;
	}
    CALayer *layer = [operationArray_ lastObject];
    [self.layer addSublayer:layer];

	[operationArray_ removeLastObject];
    [self updateUndoAndRedo];
}

/**
 * @brief 
 * 设置当前样式名称
 *
 * @param [in] 样式名称：pic_1
 * @param [out]
 * @return
 * @note
 */
- (void)setstampPicName:(NSString *)pictureName
{
	self.stampPicName = pictureName;
}

@end
