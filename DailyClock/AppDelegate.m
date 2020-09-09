//
//  AppDelegate.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/1.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "AppDelegate.h"
#import "DKApplication.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 初始化
    [[DKApplication cy_shareInstance] setup:launchOptions];
    
    return YES;
}



@end
