//
//  DKApplication.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBLPromises.h"
#import "DKSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKApplication : NSObject<UITabBarControllerDelegate>

/// 普通
@property (nonatomic, strong) NSString *fontName;
/// 粗体
@property (nonatomic, strong) NSString *boldFontName;
/// 是否24小时自动备份数据
@property (nonatomic, assign) BOOL isAutoBeifeiShuju;
/// 上次备份时间
@property (nonatomic, strong) NSDate *lastBackupDate;
/// 打卡设置项
@property (nonatomic, strong) NSMutableArray <DKSettingItem *> * settingItems;

- (void) setup:(NSDictionary *)launchInfo;

/// 保存数据到iCloud
- (FBLPromise *) p_backupToICloud;
/// 恢复数据
- (FBLPromise *) p_loadDataFromICloud;
@end

NS_ASSUME_NONNULL_END
