//
//  HttpTool.m
//  StaffEHome
//
//  Created by webthink_mac on 2017/6/3.
//  Copyright © 2017年 webthink_mac. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>
#import "XHToast.h"
#import "MBProgressHUD.h"
#import "PrefixHeader.pch"
#import "NSString+YYAdd.h"


static HttpTool * httpTool = nil;

@implementation HttpTool

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpTool = [HttpTool new];
    });
    return httpTool;
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure
{
    if (hud) {
        [HttpTool ShowHUD];
    }
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    //1、创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer  serializer];
    mgr.requestSerializer.timeoutInterval = 10;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg",
                                                     @"image/png", nil];
    [mgr setSecurityPolicy:securityPolicy];
    
    //2、发送请求
    
    [mgr POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (hud) {
            [HttpTool HiddenHUD];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (hud) {
            [HttpTool HiddenHUD];
        }
        NSLog(@"taskurl:%@ error == %@",task.currentRequest.URL, error);
        failure(error);
    }];
}


+ (void)UPLOAD:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (hud) {
        [HttpTool ShowHUD];
    }
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    //1、创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer  serializer];
    mgr.requestSerializer.timeoutInterval = 10;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html",@"application/x-jpg",@"image/jpeg",
                                                     @"image/png",  nil];
    [mgr setSecurityPolicy:securityPolicy];
    
    
    //取出图片
    NSMutableDictionary *m_params = [parameters mutableCopy];
    NSData *IMG = [parameters objectForKey:@"picture"];
    [m_params removeObjectForKey:@"picture"];
    //2、发送请求
    
    [mgr POST:URLString parameters:m_params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //采用时间来防止名字重复
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:IMG name:@"picture" fileName:fileName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (hud) {
            [HttpTool HiddenHUD];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"taskurl:%@ error == %@",task.currentRequest.URL, error);
        if (hud) {
            [HttpTool HiddenHUD];
        }
        failure(error);
    }];

}

+ (void) GET:(NSString *)interface action:(NSString *)action params:(NSMutableDictionary *)params HUD:(BOOL)hud success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:action forKey:@"Action"];
//    if (params) {
//        dic[@"content"] = [params modelToJSONString];
//    }
    [dic addEntriesFromDictionary:params];
    [self GET:interface parameters:dic HUD:YES success:success failure:failure];
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters HUD:(BOOL)hud success:(void (^)(id responseObject)) success failure:(void(^)(NSError *error)) failure
{
    if (hud) {
        [HttpTool ShowHUD];
    }
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    //1、创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer  serializer];
    mgr.requestSerializer.timeoutInterval = 10;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg",
    @"image/png", nil];
    [mgr setSecurityPolicy:securityPolicy];
    

    //2、发送请求
    NSLog(@"url == %@, params = %@",URLString,parameters);
    
    [mgr GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HttpTool HiddenHUD];
        //#ifdef DEBUG
        //
        //#endif
        NSLog(@"taskurl:%@ responseObject == %@",task.currentRequest.URL, responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"taskurl:%@ error == %@",task.currentRequest.URL, error);
        [HttpTool HiddenHUD];
        if (failure) {
            failure(error);
        }
        if (error.code != kCFURLErrorCancelled) {
            if (hud == YES) {
               [XHToast showBottomWithText:@"网络请求失败"];
            }
        }
    }];
}


 //显示挡板
+(void)ShowHUD{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         if ([UIApplication sharedApplication].keyWindow)
         {
             [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
         }
    });
    
}
 //隐藏挡板
+(void)HiddenHUD
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].keyWindow)
        {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    });
}

+ (void)ShowHUDWithMsg:(NSString *)msg
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].keyWindow) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.detailsLabel.text = msg;
            hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15];
        }
    });
}

+ (void) GETWithAction:(NSString *)action content:(NSDictionary *)content HUD:(BOOL)hud success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
}

+ (void)GETWithAction:(NSString *)action content:(NSDictionary *)content HUD:(BOOL)hud
    successWithStatus:(void (^)(id data, NSInteger statusCode,NSString *msg)) success failure:(void(^)(NSError *error)) failure
{
    [self GETWithAction:action
                content:content
                    HUD:hud
                success:^(id responseObject) {
                    id data = [responseObject objectForKey:@"returnData"]?:responseObject;
                    NSString *message = [responseObject objectForKey:@"returnMsg"];
                    NSInteger status = [[responseObject objectForKey:@"returnCode"] integerValue];
                    success?success(data,status,message):nil;
                } failure:failure];
}


@end
