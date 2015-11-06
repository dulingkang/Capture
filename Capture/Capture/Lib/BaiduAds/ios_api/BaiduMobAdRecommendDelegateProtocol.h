//
//  BaiduMobAdRecommendDelegateProtocol.h
//  BaiduMobAdSdk
//
//  Created by shaobo on 10/20/14.
//
//
#import <Foundation/Foundation.h>

///---------------------------------------------------------------------------------------
/// @name 协议板块
///---------------------------------------------------------------------------------------

@class BaiduMobAdRecommend;
/**
 *  广告sdk委托协议
 */
@protocol BaiduMobAdRecommendDelegate<NSObject>

@required
/**
 *  应用的id
 */
- (NSString *)publisherId;

@optional
/**
 *  启动位置信息
 */
-(BOOL) enableLocation;

/**
 *  推荐页面关闭
 */
- (void)recommendPageDidClosed;

/**
 *  推荐图标点击回调
 */
- (void)recommendViewDidClick;

@end
