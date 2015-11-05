//
//  GDTMobInterstitial.h
//  GDTMobApp
//
//  Created by GaoChao on 13-12-30.
//  Copyright (c) 2013年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GDTMobInterstitial;

@protocol GDTMobInterstitialDelegate <NSObject>

@optional

/**
 *  广告预加载成功回调
 *  详解:当接收服务器返回的广告数据成功后调用该函数
 */
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial;

/**
 *  广告预加载失败回调
 *  详解:当接收服务器返回的广告数据失败后调用该函数
 */
- (void)interstitialFailToLoadAd:(GDTMobInterstitial *)interstitial error:(NSError *)error;

/**
 *  插屏广告将要展示回调
 *  详解: 插屏广告即将展示回调该函数
 */
- (void)interstitialWillPresentScreen:(GDTMobInterstitial *)interstitial;

/**
 *  插屏广告视图展示成功回调
 *  详解: 插屏广告展示成功回调该函数
 */
- (void)interstitialDidPresentScreen:(GDTMobInterstitial *)interstitial;

/**
 *  插屏广告展示结束回调
 *  详解: 插屏广告展示结束回调该函数
 */
- (void)interstitialDidDismissScreen:(GDTMobInterstitial *)interstitial;

/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
- (void)interstitialApplicationWillEnterBackground:(GDTMobInterstitial *)interstitial;

/**
 *  插屏广告曝光回调
 */
- (void)interstitialWillExposure:(GDTMobInterstitial *)interstitial;

/**
 *  插屏广告点击回调
 */
- (void)interstitialClicked:(GDTMobInterstitial *)interstitial;

@end

@interface GDTMobInterstitial : NSObject

/**
 *  GPS精准广告定位模式开关,默认Gps关闭
 *  详解：[可选]GPS精准定位模式开关，YES为开启GPS，NO为关闭GPS，建议设为开启，可以获取地理位置信息，提高广告的填充率，增加收益。
 */
@property(nonatomic, assign) BOOL isGpsOn;

/**
 *  插屏广告预加载是否完成
 */
@property (nonatomic) BOOL isReady;

/**
 *  委托对象
 */
@property (nonatomic, assign) id<GDTMobInterstitialDelegate> delegate;

/**
 *  构造方法
 *  详解：appkey是应用id, placementId是广告位id
 */
-(id)initWithAppkey:(NSString *)appkey placementId:(NSString *)placementId;

/**
 *  广告发起请求方法
 *  详解：[必选]发起拉取广告请求
 */
-(void)loadAd;

/**
 *  广告展示方法
 *  详解：[必选]发起展示广告请求, 必须传入用于显示插播广告的UIViewController
 */
-(void)presentFromRootViewController:(UIViewController *)rootViewController;

@end
