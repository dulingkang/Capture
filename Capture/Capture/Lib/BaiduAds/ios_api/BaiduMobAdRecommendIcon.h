//
//  BaiduMobAdRecommendIcon.h
//  BaiduMobAdSdk
//
//  Created by lishan04 on 15-1-26.
//
//

#import <UIKit/UIKit.h>
#import "BaiduMobAdRecommendDelegateProtocol.h"
@interface BaiduMobAdRecommendIcon : UIView

@property (nonatomic, assign) id<BaiduMobAdRecommendDelegate> delegate;
/**
 * 初始化推广墙icon，frame大于5*5，可传入自定义的imageview
 */
-(id)initWithFrame:(CGRect)frame imageView:(UIImageView*)imageView delegate:(id<BaiduMobAdRecommendDelegate>) delegate;

@end
