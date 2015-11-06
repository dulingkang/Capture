//
//  BaiduMobAdCommonConfig.h
//  BaiduMobAdSdk
//
//  Created by dengjinxiang on 13-8-22.
//
//

#ifndef BaiduMobAdSdk_BaiduMobAdCommonConfig_h
#define BaiduMobAdSdk_BaiduMobAdCommonConfig_h

/**
 *  视频广告时长
 */
typedef enum {
    BaiduMobAdVideoDurationShort = 15,
    BaiduMobAdVideoDurationMiddle = 30,
    BaiduMobAdVideoDurationLong = 45
} BaiduMobAdVideoDuration;
/**
 *  性别类型
 */
typedef enum
{
	BaiduMobAdMale=0,
	BaiduMobAdFeMale=1,
    BaiduMobAdSexUnknown=2,
} BaiduMobAdUserGender;

/**
 *  广告展示失败类型枚举
 */
typedef enum _BaiduMobFailReason
{
    BaiduMobFailReason_NOAD = 0,
    // 没有推广返回
    BaiduMobFailReason_EXCEPTION,
    //网络或其它异常
    BaiduMobFailReason_FRAME
    //广告尺寸异常，不显示广告
} BaiduMobFailReason;

#endif