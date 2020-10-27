//
//  DKApplication.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication.h"
#import "DKApplication+Extension.h"
#import "FBLPromises.h"
#import "DKDocument.h"
#import <UMCommon/UMCommon.h>

@implementation DKApplication
- (id) init{
    self = [super init];
    if (self) {
        self.isAutoBeifeiShuju = YES;
        self.fontName = @"HappyZcool-2016";
        self.boldFontName = @"HappyZcool-2016";
        self.settingItems = [DKSettingItem allSettings];
    }
    return self;
}

- (void)setup:(NSDictionary *)launchInfo{
    
    //注册友盟
    [UMConfigure initWithAppkey:UM_APPKEY channel:nil];
    [UMConfigure setLogEnabled:YES];
    
    [self initwindow:launchInfo];
    [self configJPush:launchInfo];
    /// 自动备份
    [self autoBackup];
    
    /// 注册下载字体
    [self regisetFonts];

}

- (void) autoBackup{
    /// 达到自动备份时间和用户自动备份开关是打卡着的
    if ([[NSDate date] timeIntervalSinceDate:self.lastBackupDate] > 24 * 60 * 60 &&
        self.isAutoBeifeiShuju == YES) {
        [self p_backupToICloud];
    }
}

- (void) regisetFonts {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"fonts"];
    if ([manager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSArray *items = [manager contentsOfDirectoryAtPath:path error:&error];
        [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *url = [path stringByAppendingPathComponent:obj];
                [UIFont loadFontFromPath:url];
            }
        }];
    }
}

- (FBLPromise *) p_backupToICloud{
    return [FBLPromise onQueue:dispatch_get_main_queue() async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        NSURL *url = [[self icloudContainerBaseURL]URLByAppendingPathComponent:@"DKTargetManager"];
        DKDocument *document = [[DKDocument alloc] initWithFileURL:url targetData:[FastCoder dataWithRootObject:[DKTargetManager cy_shareInstance]]];
        [document saveToURL:url forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
            if (success) {
                /// 更新上次备份时间
                [DKApplication cy_shareInstance].lastBackupDate = [NSDate date];
                [[DKApplication cy_shareInstance] cy_save];
                fulfill(@YES);
            }
            else{
                reject([NSError errorWithDomain:@"com.backuptoicloud" code:-1 userInfo:nil]);
            }
        }];
    }];
}

- (NSURL *)icloudContainerBaseURL
{
    if ([NSFileManager defaultManager].ubiquityIdentityToken)
    {
        return [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    }
    
    return nil;
}

- (FBLPromise *) p_loadDataFromICloud{
    return [FBLPromise onQueue:dispatch_get_main_queue() async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        
        __block NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
        query.searchScopes = @[NSMetadataQueryUbiquitousDataScope];
        query.predicate = [NSPredicate predicateWithFormat:@"%K == 'DKTargetManager'", NSMetadataItemFSNameKey];
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSMetadataQueryDidFinishGatheringNotification object:query] subscribeNext:^(NSNotification * _Nullable x) {
            if (query.results.count!=0) {
                 NSURL *fileURL = [(NSMetadataItem *)query.results.firstObject valueForAttribute:NSMetadataItemURLKey];
                DKDocument *document = [[DKDocument alloc] initWithFileURL:fileURL targetData:nil];
                [document openWithCompletionHandler:^(BOOL success) {
                    if (success) {
                        /// 置空旧的单例
                        [DKTargetManager resetModel];
                        DKTargetManager* cy_shareInstance = [FastCoder objectWithData:document.data];
                        [cy_shareInstance cy_save];
                        fulfill(document.data);
                    }
                    else{
                        reject([NSError errorWithDomain:@"com.backuptoicloud" code:-2 userInfo:nil]);
                    }
                }];
            }
        }];
        [query startQuery];
    }];
}


@end
