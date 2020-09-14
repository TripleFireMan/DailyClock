//
//  AppDelegate.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/1.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "AppDelegate.h"
#import "DKApplication.h"
#import "JPUSHService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 初始化
    [[DKApplication cy_shareInstance] setup:launchOptions];
    
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken:%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void) applicationDidEnterBackground:(UIApplication *)application{
    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
}


@end
