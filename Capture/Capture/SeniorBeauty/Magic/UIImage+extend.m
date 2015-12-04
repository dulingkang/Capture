//
//  UIImage-Extensions.m
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/EAGL.h>
#import "UIImage+extend.h"
#import <OpenGLES/ES2/gl.h>

#define minColor255(x) ((x) > (255)?(255):(x))
CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (extend)

//截取部分图像
-(UIImage*)subImageAtRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    // 设置图片旋转方向
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1.0f orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
	CGImageRelease(subImageRef);
	
    return smallImage;
}

//等比例缩放
-(UIImage*)imageScaledToSize:(CGSize)size 
{
	CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
	
	float verticalRadio = size.height*1.0/height; 
	float horizontalRadio = size.width*1.0/width;
	
	float radio = 1;
	if(verticalRadio>1 && horizontalRadio>1)
	{
		radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;	
	}
	else
	{
		radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;	
	}
	
	width = width*radio;
	height = height*radio;
	
	int xPos = (size.width - width)/2;
	int yPos = (size.height-height)/2;
	
	// 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    UIGraphicsBeginImageContext(size);  
	
    // 绘制改变大小的图片  
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];  
	
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
	
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
	
    // 返回新的改变大小后的图片  
    return scaledImage;
}

-(UIImage *)imageAtRect:(CGRect)rect
{
	
	CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
	UIImage* subImage = [UIImage imageWithCGImage: imageRef];
	CGImageRelease(imageRef);
	
	return subImage;
	
}
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor > heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor > heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor < heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
		
		CGFloat widthFactor = targetWidth / width;
		CGFloat heightFactor = targetHeight / height;
		
		if (widthFactor < heightFactor)
			scaleFactor = widthFactor;
		else
			scaleFactor = heightFactor;
		
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		
		// center the image
		
		if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		} else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	
	targetSize.width = floorf(targetSize.width);
    targetSize.height = floorf(targetSize.height);
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = floorf(scaledWidth);
	thumbnailRect.size.height = floorf(scaledHeight);
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	//   CGSize imageSize = sourceImage.size;
	//   CGFloat width = imageSize.width;
	//   CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	//   CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
	return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{ 
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
	
}

/**
 * @brief 切割图片
 * @param [in] 
 * @return
 * @note 
 */
- (UIImage *)scaleImage:(UIImage *)image withRect:(CGRect)targetRect
{
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, targetRect);
    CGSize size = targetRect.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, targetRect, subImageRef);
    UIImage *cutImage = [UIImage imageWithCGImage:subImageRef];  
    UIGraphicsEndImageContext();
	CGImageRelease(subImageRef);
	return cutImage;
	
}

#pragma mark - Effect:Lomo, HDR,....
/**
 * @brief 
 * 特效：lomo
 * 直接操作的图片内数据，所以没有返回值
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)lomoEffectAtImage:(ImageInfo *)imageInfo withBrightRadius:(float)radius needBalanceColor:(BOOL)flag
{
//    if (flag)
//    {
//        [EffectMethods balanceColorWithInImage:imageInfo 
//                                      withCyan:-80
//                                   withMagenta:0 
//                                    withYellow:-60 
//                              withTransferMode:ETransferMidtones
//                        withPreserveLuminosity:true];
//
//    }
//    //调整色阶会有杂点产生，暂时先注释
////    [EffectMethods adjustLevelsWithInImage:inImageInfo WithBlackLimit:27 WithWhiteLimit:255 WithGamma:0.96 WithChanel:EChanelRGB];
//    [EffectMethods darkenCornerWithInImage:imageInfo withBrightRatio:radius withMaskAlpha:200];
//    return nil;
}

/**
 * @brief 
 * 特效：old photo
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)oldPhotoEffectAtImage:(ImageInfo *)imageInfo withRatio:(float)ratio needGrayScale:(BOOL)flag
{
#if  0
    unsigned char *imgPixel = [Common RequestImagePixelData:inImage];
	CGImageRef inImageRef = [inImage CGImage];
	GLuint imgWidth = CGImageGetWidth(inImageRef);
	GLuint imgHeight = CGImageGetHeight(inImageRef);
	
	int wOff = 0;
	int pixOff = 0;	
	for(GLuint y = 0;y < imgHeight;++y) 
    {
		pixOff = wOff;		
		for (GLuint x = 0; x < imgWidth; ++x) 
        {
            //取出点（x，y）的rgb值
			int red = (unsigned char)imgPixel[pixOff];
			int green = (unsigned char)imgPixel[pixOff+1];
			int blue = (unsigned char)imgPixel[pixOff+2];
			
            //通过相应矩阵计算出新的rgb
            int newR = (int) (0.393 *red + 0.769 *green + 0.189 * blue);
            int newG = (int) (0.349 *red + 0.686 *green + 0.168 * blue);
            int newB = (int) (0.272 *red + 0.534 *green + 0.131 *blue);
			imgPixel[pixOff] = minColor255(newR);
            imgPixel[pixOff+1] = minColor255(newG);
            imgPixel[pixOff + 2] = minColor255(newB);
			pixOff += 4;
		}
		wOff += imgWidth * 4;
	}
	return [Common GenerateImageFromData:imgPixel 
                       withImgPixelWidth:imgWidth 
                      withImgPixelHeight:imgHeight];
#endif 
    
    int cyan = 34 *ratio;
    int yellow = - 87 *ratio;
//    if (flag)
//    {
//        [EffectMethods grayScaleWithImageInfo:imageInfo];
//
//    }
//    
//    [EffectMethods balanceColorWithInImage:imageInfo withCyan:cyan withMagenta:0 withYellow:yellow withTransferMode:ETransferMidtones withPreserveLuminosity:false];
    
}

/**
 * @brief 
 * 特效：invert
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)invertEffectAtImage:(ImageInfo *)imageInfo
{
//    unsigned char lookup[256];
//    for (int i = 0; i < 256; ++i)
//    {
//        lookup[i] = 255 - i;
//    }
//    [EffectMethods adjustCurveWithInImage:imageInfo withLookup:lookup withChanel:EChanelRGB];
}

/**
 * @brief 
 * 特效：sketch
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)sketchEffectAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity needGrayScale:(BOOL)flag
{
//    if (flag)
//    {
//        //灰度化原图
//        [EffectMethods grayScaleWithImageInfo:imageInfo];
//    }
//
//
//
//    //拷贝灰度化后的原图并反向
//    ImageInfo *clone = [imageInfo clone];
//    [UIImage invertEffectAtImage:clone];
//    
//    //对拷贝图做高斯模糊
////    [EffectMethods gaussianBlurWithImageInfo:clone andRadius:10];
//    //高斯模糊太慢
//    [ColorEffectsCommon fastBlurImage:clone radius:10];
//
//    //todo 颜色减淡
//    [EffectMethods blendMode:imageInfo withBlend:clone withOpacity:opacity];


}

/**
 * @brief 
 * 特效：hdr
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
//+ (void)HDREffectAtImage:(ImageInfo *)imageInfo withGamma:(float)gamma
//{
//    [EffectMethods exposure:imageInfo blackThreshold:40 whiteThreshold:300 gamma:gamma];
//    
//}


/**
 * @brief 图片色调分离
 * 特效：水彩画
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)posterize:(ImageInfo *)imageInfo withLevels:(double)levels{
//	unsigned char *imgPixel = imageInfo.data;
//	GLuint imgWidth = (GLuint)imageInfo.width;
//	GLuint imgHeight = (GLuint)imageInfo.height;
//	//获取number of bytes/Pixel
//    GLuint imgBpp = (GLuint)imageInfo.bytesPerPixel;
//    //跨距，一行像素的宽度
//    GLuint imgBytesPerRow = (GLuint)imageInfo.bytesPerRow;
//    int offset = imgBytesPerRow - imgWidth * imgBpp;
//	
//#if 1
//	float numOfAreas = 256.0/levels;
//	float numOfValues = 255.0/(levels - 1);
//	
//	for(GLuint y = 0;y< imgHeight;y++) {		
//		for (GLuint x = 0; x< imgWidth; x++) {
//			int red = (unsigned char)imgPixel[0];
//			int green = (unsigned char)imgPixel[1];
//			int blue = (unsigned char)imgPixel[2];
//			
//			float redAreaFloat = red/numOfAreas;
//			
//		    int redArea = (int)(redAreaFloat);
//			if (redArea > redAreaFloat) 
//			{
//				redArea = redArea -1;
//			}
//			
//			float newRedFloat = numOfValues * redArea;
//			int newRed = newRedFloat;
//			if (newRed > newRedFloat) 
//			{
//				newRed = newRed - 1;
//			}
//			
//			float greenAreaFloat = green/numOfAreas;
//			
//		    int greenArea = (int)(greenAreaFloat);
//			if (greenArea > greenAreaFloat) 
//			{
//				greenArea = greenArea -1;
//			}
//			
//			float newGreenFloat = numOfValues * greenArea;
//			int newGreen = newGreenFloat;
//			if (newGreen > newGreenFloat) 
//			{
//				newGreen = newGreen - 1;
//			}
//			
//			float blueAreaFloat = blue/numOfAreas;
//			
//		    int blueArea = (int)(blueAreaFloat);
//			if (blueArea > blueAreaFloat) 
//			{
//				blueArea = blueArea -1;
//			}
//			
//			float newBlueFloat = numOfValues * blueArea;
//			int newBlue = newBlueFloat;
//			if (newBlue > newBlueFloat) 
//			{
//				newBlue = newBlue - 1;
//			}
//			
//			imgPixel[0] = newRed;
//			imgPixel[1] = newGreen;
//			imgPixel[2] = newBlue;
//			imgPixel += imgBpp;
//		}
//		imgPixel += offset;
//	}
//	
//#endif
//#if 0
//    int step = 255.0/levels;
//	for(GLuint y = 0;y< imgHeight;y++) {		
//		for (GLuint x = 0; x< imgWidth; x++) {
//			//int alpha = (unsigned char)imgPixel[pixOff];
//			int red = (unsigned char)imgPixel[0];
//			int green = (unsigned char)imgPixel[1];
//			int blue = (unsigned char)imgPixel[2];
//            
//            imgPixel[0] = minColor255((red / step) * step);
//			imgPixel[1] = minColor255((green / step) * step);
//			imgPixel[2] = minColor255((blue / step) * step);
//            
//			imgPixel += imgBpp;
//		}
//		imgPixel += offset;
//	}
//#endif
	
	
}



/**
 * @brief 
 * 特效：黑白
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)blackWhite:(ImageInfo *)imageInfo withLevels:(int)value{
//	unsigned char *imgPixel = imageInfo.data;
//	GLuint imgWidth = (GLuint)imageInfo.width;
//	GLuint imgHeight = (GLuint)imageInfo.height;
//	//获取number of bytes/Pixel
//    GLuint imgBpp = (GLuint)imageInfo.bytesPerPixel;
//    //跨距，一行像素的宽度
//    GLuint imgBytesPerRow = (GLuint)imageInfo.bytesPerRow;
//    int offset = imgBytesPerRow - imgWidth * imgBpp;
//	
//	for(GLuint y = 0;y< imgHeight;y++) {
//		for (GLuint x = 0; x<imgWidth; x++) {
//			//int alpha = (unsigned char)imgPixel[pixOff];
//			int red = (unsigned char)imgPixel[0];
//			int green = (unsigned char)imgPixel[1];
//			int blue = (unsigned char)imgPixel[2];
//			
//			int bw = (int)((red+green+blue)/3.0);
//			
//			bw = (bw > value)?255:0;
//			imgPixel[0] = bw;
//			imgPixel[1] = bw;
//			imgPixel[2] = bw;
//			
//			imgPixel += imgBpp;
//		}
//		imgPixel += offset;
//	}  
}


/**
 * @brief 
 * 特效：双色调／黄蓝色调
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
/*+(void)duoTone:(ImageInfo *)imageInfo 
{
    [EffectMethods grayScaleWithImageInfo:imageInfo];
    unsigned char *imgPixel = imageInfo.data;
	GLuint imgWidth = imageInfo.width;
	GLuint imgHeight = imageInfo.height;
	//获取number of bytes/Pixel
    GLuint imgBpp = imageInfo.bytesPerPixel;
    //跨距，一行像素的宽度
    GLuint imgBytesPerRow = imageInfo.bytesPerRow;
    int offset = imgBytesPerRow - imgWidth * imgBpp;
	
	for(GLuint y = 0;y< imgHeight;y++) 
    {
		for (GLuint x = 0; x<imgWidth; x++) 
        {
            int red = (unsigned char)imgPixel[0];
            int green = (unsigned char)imgPixel[1];
            int blue = (unsigned char)imgPixel[2];
            int gray = (unsigned char)imgPixel[0];
			if (gray < 127) {
                red = 0;                
                green = 0;
                blue = 255;
            }
			else
            {
                red = 255;                
                green = 255;
                blue = 0;
            }
            imgPixel[0] = red;
			imgPixel[1] = green;
			imgPixel[2] = blue;
                 
            imgPixel += imgBpp;
		}
		imgPixel += offset;
	}   
}
*/
+ (void)duoTone:(ImageInfo *)imageInfo withLevel:(int)value
{
//    [EffectMethods grayScaleWithImageInfo:imageInfo];
//    unsigned char *imgPixel = imageInfo.data;
//	GLuint imgWidth = (GLuint)imageInfo.width;
//	GLuint imgHeight = (GLuint)imageInfo.height;
//	//获取number of bytes/Pixel
//    GLuint imgBpp = (GLuint)imageInfo.bytesPerPixel;
//    //跨距，一行像素的宽度
//    GLuint imgBytesPerRow = (GLuint)imageInfo.bytesPerRow;
//    int offset = imgBytesPerRow - imgWidth * imgBpp;
//	
//	for(GLuint y = 0;y< imgHeight;y++) 
//    {
//		for (GLuint x = 0; x<imgWidth; x++) 
//        {
//            int red = (unsigned char)imgPixel[0];
//            int green = (unsigned char)imgPixel[1];
//            int blue = (unsigned char)imgPixel[2];
//            int gray = (unsigned char)imgPixel[0];
//			if (gray < 128 - value ) 
//            {
//                red = 0;                
//                green = 0;
//                blue = 255;
//            }
//		     else if (gray > 128 + value)
//            {
//                red = 255;                
//                green = 255;
//                blue = 0;
//            }
//            else
//            {
//                red = 255;                
//                green = 255;
//                blue = 255;
//            }
//           
//            imgPixel[0] = CLAMP0255(red);
//			imgPixel[1] = CLAMP0255(green);
//			imgPixel[2] = CLAMP0255(blue);
//            
//            imgPixel += imgBpp;
//		}
//		imgPixel += offset;
//	}   

}




/*
 * @brief 
 * 特效：电流色
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)heatMap:(ImageInfo *)imageInfo
{
//    [EffectMethods grayScaleWithImageInfo:imageInfo];
//    unsigned char *imgPixel = imageInfo.data;
//	GLuint imgWidth = (GLuint)imageInfo.width;
//	GLuint imgHeight = (GLuint)imageInfo.height;
//	//获取number of bytes/Pixel
//    GLuint imgBpp = (GLuint)imageInfo.bytesPerPixel;
//    //跨距，一行像素的宽度
//    GLuint imgBytesPerRow = (GLuint)imageInfo.bytesPerRow;
//    int offset = imgBytesPerRow - imgWidth * imgBpp;	
// 
//    for (GLint y = 0; y < imgHeight; y ++)
//    {
//        for (GLint x = 0; x < imgWidth; x ++)
//        {
//            int red ,green ,blue,gray;
//            red = (unsigned char) imgPixel[0];
//            green = (unsigned char) imgPixel[1];
//            blue = (unsigned char) imgPixel[2];
//            gray = (unsigned char) imgPixel[0];
//            if (gray < 64) {
//                red = 0;
//                green = 8/3 * gray;
//                blue = gray * 2 + 128;
//            }
//            else if (gray < 96){
//                red = 0;
//                green = 8/3 * gray;
//                blue = 511 - gray * 4;
//            }
//            else if (gray < 128){
//                red = 0;
//                green = 255;
//                blue = 511 - gray * 4;
//            }
//            else if (gray < 176){
//                red = 16/3 * (gray - 128);
//                green = 255;
//                blue = 0;
//            }
//            else if (gray < 208){
//                red = 255;
//                green = -16/3 * (gray - 224);
//                blue = 0;
//            }
//            else if (gray < 224){
//                red = 128 - 8/3 * (gray - 256);
//                green = -16/3 * (gray - 224);
//                blue = 0;
//            }
//            else{
//                red = 128 - 8/3 * (gray - 256);
//                green = 0;
//                blue = 0;
//            }
//            imgPixel[0] = red;
//            imgPixel[1] = green;
//            imgPixel[2] = blue;
//            
//            imgPixel += imgBpp;           
//        }
//        imgPixel += offset;
//    }
}





/**
 * @brief 
 * 特效：柔和
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)softlightAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity
{
//    ImageInfo *clone = [imageInfo clone];
//    // 对拷贝图做高斯模糊
////    [EffectMethods gaussianBlurWithImageInfo:clone andRadius:5];
//    [ColorEffectsCommon fastBlurImage:clone radius:1];
//    // 对原图适当调整亮度
//    [ColorEffectsCommon brightness:clone level:0.05];
//    // 将两个图形做滤色混合
//    [EffectMethods blendMode:imageInfo withBlend:clone withMode:0 withOpacity:opacity];
    
}
/**
 * @brief 
 * 特效：反转片
 * @param [in] imageInfo ---待处理的图片
 * @param [out]
 * @return 
 * @note
 */
+ (void)reversalFilmAtImage:(ImageInfo *)imageInfo withOpacity:(float)opacity
{
//    NSLog(@"%f", opacity);
//#if 0
//    ImageInfo *clone1 = [imageInfo clone];
//    ImageInfo *clone2 = [imageInfo clone];
//    ImageInfo *clone3 = [imageInfo clone];
//
//    // 对拷贝图做高斯模糊
////    [EffectMethods gaussianBlurWithImageInfo:clone2 andRadius:11];
//    [ColorEffectsCommon fastBlurImage:clone2 radius:8];
//    [EffectMethods BlendModeCurve:clone1 withBlend:clone2 withlookup:nil];
//    [EffectMethods blendMode:imageInfo withBlend:clone1 withMode:1 withOpacity:opacity];
//    
//    // 给图片增加杂点
////    [EffectMethods addNoiseWithImageInfo:clone3 andDegree:5];
////    [EffectMethods blendMode:imageInfo withBlend:clone3 withMode:3 withOpacity:opacity];
////    [ColorEffectsCommon saturation:imageInfo level:0.5f];
//#endif
//    ImageInfo *clone = [imageInfo clone];
//    [ColorEffectsCommon saturation:clone level:-opacity];
//    [EffectMethods blendMode:imageInfo withBlend:clone withMode:1 withOpacity:opacity];

}
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
        withOpacity:(float)opacity
{
//    ImageInfo *clone = [imageInfo clone];
//    // 边缘检测
//    [EffectMethods neonWithInImage:imageInfo red:red green:green blue:blue];  
//    [ColorEffectsCommon brightness:clone level:-opacity];
//    [EffectMethods blendMode:imageInfo withClone:clone];
//    
//#if 0
//    // 单色处理
////    [EffectMethods grayScaleWithImageInfo:clone];
//    [EffectMethods piexlSingleWithInImageInfo:clone];
//    
//    [ColorEffectsCommon balanceColor:clone cyan:100 magenta:0 yellow:0 mode:1 luminosity:YES];    
////    [ColorEffectsCommon saturation:clone level:1.0];
////    [ColorEffectsCommon brightness:clone level:-0.039];
//    [ColorEffectsCommon brightness:imageInfo level:-opacity];
//    // 将两个图形做滤色混合
//    [EffectMethods blendMode:imageInfo withBlend:clone withMode:2 withOpacity:opacity];
//#endif
    
}
@end;
