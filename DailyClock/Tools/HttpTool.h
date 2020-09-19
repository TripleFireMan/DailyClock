//
//  HttpTool.h
//  StaffEHome
//
//  Created by webthink_mac on 2017/6/3.
//  Copyright © 2017年 webthink_mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpTool : NSObject

+ (void)POST:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;

+ (void)GET:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;


+ (void)UPLOAD:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure;
+(void)ShowHUD; //显示挡板
+(void)HiddenHUD; //隐藏挡板
+(void)ShowHUDWithMsg:(NSString *)msg;

@end
