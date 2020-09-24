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
#import "FastCoder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 初始化
    [[DKApplication cy_shareInstance] setup:launchOptions];
    [self p_save];
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
    
    [self p_save];
}

- (void) p_save{
    NSUserDefaults *userDefault =  [[NSUserDefaults alloc] initWithSuiteName:@"group.com.chengyan.DailyClock"];
    DKTargetModel *model = [[[DKTargetManager cy_shareInstance] activeModels] firstObject];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (model) {
        
        [dictionary setObject:model.icon forKey:@"icon"];
        [dictionary setObject:model.title forKey:@"title"];
        [dictionary setObject:[NSString stringWithFormat:@"%@次",@(model.signModels.count)] forKey:@"days"];
        [dictionary setObject:model.backgroundImage forKey:@"bg"];
        [dictionary setObject:@(NO) forKey:@"sign"];
    }
    else{
        [dictionary setObject:@"dog" forKey:@"icon"];
        [dictionary setObject:@"遛狗" forKey:@"title"];
        [dictionary setObject:[NSString stringWithFormat:@"%@次",@(1)] forKey:@"days"];
        [dictionary setObject:@"bbg1" forKey:@"bg"];
        [dictionary setObject:@(NO) forKey:@"sign"];
    }
    [userDefault setObject:dictionary forKey:@"shareData"];
    [userDefault synchronize];
}


@end
