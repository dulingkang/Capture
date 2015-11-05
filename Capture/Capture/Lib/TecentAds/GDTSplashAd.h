//
//  GDTSplashAd.h
//  GDTMobApp
//
//  广点通开屏广告，目前只支持iPhone设备上展示垂直方向的开屏广告
//  Created by GaoChao on 15/8/20.
//  Copyright © 2015年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GDTSplashAd;

@protocol GDTSplashAdDelegate <NSObject>

/**
 *  开屏广告成功展示
 */
-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd;

/**
 *  开屏广告展示失败
 */
-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error;

/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
- (void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd;

/**
 *  开屏广告点击回调
 */
- (void)splashAdClicked:(GDTSplashAd *)splashAd;

/**
 *  开屏广告关闭回调
 */
- (void)splashAdClosed:(GDTSplashAd *)splashAd;

@end

@interface GDTSplashAd : NSObject

/**
 *  委托对象
 */
@property (nonatomic, assign) id<GDTSplashAdDelegate> delegate;

/**
 *  拉取广告超时时间，默认为3秒
 *  详解：拉取广告超时时间，开发者调用loadAd方法以后会立即展示backgroundColor，然后在该超时时间内，如果广告拉
 *  取成功，则立马展示开屏广告，否则放弃此次广告展示机会。
 */
@property (nonatomic, assign) int fetchDelay;

/**
 *  开屏广告的背景色
 *  可以设置开屏图片来作为开屏加载时的默认图片
 */
@property (nonatomic, copy) UIColor *backgroundColor;

/**
 *  构造方法
 *  详解：appkey是应用id, placementId是广告位id
 */
-(instancetype)initWithAppkey:(NSString *)appkey placementId:(NSString *)placementId;

/**
 *  广告发起请求并展示在Window中
 *  详解：[必选]发起拉取广告请求,并将获取的广告以全屏形式展示在传入的Window参数中
 *  @param window 展示全屏开屏的容器
 */
-(void)loadAdAndShowInWindow:(UIWindow *)window;

@end
