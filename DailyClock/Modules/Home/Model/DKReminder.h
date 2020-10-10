//
//  DKReminder.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DKTargetModel;

typedef NS_ENUM(NSInteger, DKTargetDuration){
    DKTargetDuration_EveryDay,
    DKTargetDuration_Weekday,
    DKTargetDuration_Weekends,
    DKTargetDuration_Monday,
    DKTargetDuration_Tuesday,
    DKTargetDuration_Wendsday,
    DKTargetDuration_Thursday,
    DKTargetDuration_Friday,
    DKTargetDuration_Saturday,
    DKTargetDuration_Sunday,
};

NS_ASSUME_NONNULL_BEGIN

@interface DKReminder : NSObject

/// 是否是第一个添加按钮
@property (nonatomic, assign) BOOL isAdd;
/// 提醒时间
@property (nonatomic, strong) NSDate *clockDate;
/// 当前目标模型
@property (nonatomic, weak  ) DKTargetModel *targetModel;
/// 提醒间隔字符串
@property (nonatomic, copy  ) NSString *dayOfWeeks;
/// 提醒间隔
@property (nonatomic, assign) DKTargetDuration duration;
@end

NS_ASSUME_NONNULL_END
