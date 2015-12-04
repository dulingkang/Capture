//
//  UIImage-Extensions.h
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageInfo;

@interface UIImage (extend)
- (UIImage *)subImageAtRect:(CGRect)rect;
- (UIImage *)imageScaledToSize:(CGSize)size;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
/**
 * @brief 切割图片
 * @param [in] 
 * @return
 * @note 
 */
- (UIImage *)scaleImage:(UIImage *)image withRect:(CGRect)targetRect;

#pragma mark - Effect:Lomo, HDR,....
/**
 * @brief 
 * 特效：lomo
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)lomoEffectAtImage:(ImageInfo *)imageInfo withBrightRadius:(float)radius needBalanceColor:(BOOL)flag;

/**
 * @brief 
 * 特效：old photo
 * @param [in] ImageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)oldPhotoEffectAtImage:(ImageInfo *)imageInfo withRatio:(float)ratio needGrayScale:(BOOL)flag;

/**
 * @brief 
 * 特效：invert
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)invertEffectAtImage:(ImageInfo *)imageInfo;


/**
 * @brief 
 * 特效：sketch
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)sketchEffectAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity needGrayScale:(BOOL)flag;

/**
 * @brief 
 * 特效：hdr
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)HDREffectAtImage:(ImageInfo *)imageInfo withGamma:(float)gamma;


/**
 * @brief 图片色调分离
 * 特效：水彩画
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)posterize:(ImageInfo *)imageInfo withLevels:(double)levels;

/**
 * @brief 
 * 特效：黑白
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)blackWhite:(ImageInfo *)imageInfo withLevels:(int)value;
/**
 * @brief 
 * 特效：柔和
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */

+ (void)softlightAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity;
/**
 * @brief 
 * 特效：电流色
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)heatMap:(ImageInfo *)imageInfo;
/**
 * @brief 
 * 特效：双色调／黄蓝色调
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+(void)duoTone:(ImageInfo *)imageInfo withLevel:(int)value;

/**
 * @brief 
 * 特效：反转片
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)reversalFilmAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity;
/**
 * @brief 
 * 特效：霓虹灯
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)neonAtImage:(ImageInfo *)imageInfo 
                red:(int)red 
              green:(int)green 
               blue:(int)blue 
        withOpacity:(float)opacity;
@end;
