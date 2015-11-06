//
//  BaiduMobAdVideoDelegate.h
//  BaiduMobAdSdk
//
//  Created by lishan04 on 15-6-8.
//
//

#import <Foundation/Foundation.h>
#import "BaiduMobAdCommonConfig.h"

@class BaiduMobAdVideoView;

@protocol BaiduMobAdVideoDelegate <NSObject>

@required
/**
 *  应用的APPID
 */
- (NSString *)publisherId;

@optional
/**
 *  启动位置信息
 */
-(BOOL) enableLocation;

/**
 *  广告准备播放
 */
- (void)didReadyForDisplay:(BaiduMobAdVideoView *)video;

/**
 *  广告展示成功
 */
- (void)videoSuccessPresentScreen:(BaiduMobAdVideoView *)video;

/**
 *  广告展示失败
 */
- (void)videoFailPresentScreen:(BaiduMobAdVideoView *)video withError:(BaiduMobFailReason) reason;

/**
 *  广告展示结束
 */
- (void)videoDidDismissScreen:(BaiduMobAdVideoView *)video;

/**
 *  广告点击
 */
- (void)videoClicked:(BaiduMobAdVideoView *)video;

///---------------------------------------------------------------------------------------
/// @name 人群属性板块
///---------------------------------------------------------------------------------------

/**
 *  关键词数组
 */
-(NSArray*) keywords;

/**
 *  用户性别
 */
-(BaiduMobAdUserGender) userGender;

/**
 *  用户生日
 */
-(NSDate*) userBirthday;

/**
 *  用户城市
 */
-(NSString*) userCity;


/**
 *  用户邮编
 */
-(NSString*) userPostalCode;


/**
 *  用户职业
 */
-(NSString*) userWork;

/**
 *  - 用户最高教育学历
 *  - 学历输入数字，范围为0-6
 *  - 0代表小学，1代表初中，2代表中专/高中，3代表专科
 *  - 4代表本科，5代表硕士，6代表博士
 */
-(NSInteger) userEducation;

/**
 *  - 用户收入
 *  - 收入输入数字,以元为单位
 */
-(NSInteger) userSalary;

/**
 *  用户爱好
 */
-(NSArray*) userHobbies;

/**
 *  其他自定义字段,key以及value都为NSString
 */
-(NSDictionary*) userOtherAttributes;


@end
