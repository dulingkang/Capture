//
//  AppDelegate.swift
//  Capture
//
//  Created by ShawnDu on 15/11/5.
//  Copyright © 2015年 ShawnDu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gdtSplashAds:GDTSplashAd?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func addGDTSplashAds() {
        if (gdtSplashAds == nil) {
            
        }
    }
    
//    - (void)addGDTSplashAds {
//    if (gdtSplashAds == nil) {
//    gdtsp
//    _gdtSplashAds = [[GDTSplashAd alloc] initWithAppkey:GDTAdsId placementId:GDTFlashID];
//    }
//    _gdtSplashAds.delegate = self;//设置代理
//    //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
//    _gdtSplashAds.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage"]];
//    //设置开屏拉取时长限制，若超时则不再展示广告
//    _gdtSplashAds.fetchDelay = 6;
//    //拉取并展示
//    [_gdtSplashAds loadAdAndShowInWindow:self.window];
//    }


}

