//
//  PaintingView.h
//  Aico
//
//  Created by jiang liyin on 12-05-09.
//  Copyright 2011 cienet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintingView : UIView {
	NSMutableArray *operationArray_;        //撤销、恢复数组
	
	NSString       *stampPicName_;          //按钮名称
	
    CGPoint        lastPoint_;              //上一个点坐标
    CGFloat        imageSize_;              //图片外接圆直径
    NSTimer       *touchEndTimer_;          //手指离开屏幕时间定时器
    CGFloat        lastImageSize_;          //上个点所绘制图片大小
    CGSize         layerSize_;              //依据图片计算出的显示每个小图的layer大小
}
@property(nonatomic,strong) NSMutableArray *operationArray;
@property(nonatomic,copy)   NSString       *stampPicName;
@property(nonatomic,assign) CGFloat        imageSize;
@property(nonatomic,assign) int        maxScaleRatio;
@property(nonatomic,strong) NSTimer *touchEndTimer;

/**
 * @brief 
 * 获取每个点处将要绘制的图片
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (UIImage *)getImageAtEachPoint;
/**
 * @brief 
 * 给每个点添加calayer
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)addAnimationLayerWithImageName:(UIImage *)image atPoint:(CGPoint)point;
/**
 * @brief 
 * 更新撤销和恢复图片
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)updateUndoAndRedo;

/**
 * @brief 
 * 截取当前绘画视图
 *
 * @param [in]
 * @param [out]
 * @return 截取的图片
 * @note
 */
- (UIImage *)getCurrentPic;
/**
 * @brief 
 * 撤销操作
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)backwardDrawing;
/**
 * @brief 
 * 恢复操作
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)forwardDrawing;

/**
 * @brief 
 * 设置当前徽章图片名称
 *
 * @param [in] 图片名称
 * @param [out]
 * @return
 * @note
 */
- (void)setstampPicName:(NSString *)pictureName;

/**
 * @brief 
 * 更新ReUnManager  snapimage
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
- (void)updateImageSnap;


/**
 * @brief 
 * 将最后的layer设置为不透明
 *
 * @param [in]
 * @param [out]
 * @return
 * @note
 */
-(void)setLastLayerOpacity;
@end
