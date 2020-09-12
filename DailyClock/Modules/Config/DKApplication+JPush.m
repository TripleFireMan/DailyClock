//
//  DKApplication+JPush.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/12.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication+JPush.h"
#import "DKApplication+Extension.h"


@implementation DKApplication (JPush)

- (void) configJPush:(NSDictionary *)launchInfo{
    //注册
    [JPUSHService setupWithOption:launchInfo appKey:JPushAppKey
                          channel:JPushChannel
                 apsForProduction:YES];
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    

    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kJPFNetworkDidLoginNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSLog(@"kJPFNetworkDidLoginNotification-------%@",x);
        //注册别名
//        NSString *ID = [USER_D objectForKey:@"ID"];
//        if ([ID isKindOfClass:[NSString class]] && [ID length]!=0) {
//            [JPUSHService setAlias:[USER_D objectForKey:@"ID"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                if (iResCode == 0) {
//                    NSLog(@"添加别名成功:%@",iAlias);
//                }
//            } seq:1];
//        }
    }];
}

/*
 * @brief handle UserNotifications.framework [willPresentNotification:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 前台得到的的通知对象
 * @param completionHandler 该callback中的options 请使用UNNotificationPresentationOptions
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler
{
    
}
/*
 * @brief handle UserNotifications.framework [didReceiveNotificationResponse:withCompletionHandler:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param response 通知响应对象
 * @param completionHandler
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
}

/*
 * @brief handle UserNotifications.framework [openSettingsForNotification:]
 * @param center [UNUserNotificationCenter currentNotificationCenter] 新特性用户通知中心
 * @param notification 当前管理的通知对象
 */
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification NS_AVAILABLE_IOS(12.0){
    
}

@end
