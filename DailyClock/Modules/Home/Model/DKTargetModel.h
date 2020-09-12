//
//Created by ESJsonFormatForMac on 20/09/03.
//

#import <Foundation/Foundation.h>
#import "DKSignModel.h"

@class DKTargetPinCiWeekModel;

typedef NS_ENUM(NSInteger, DKTargetPinCiType){
    DKTargetPinCiType_Guding = 0,
    DKTargetPinCiType_Week,
    DKTargetPinCiType_Month,
};

typedef NS_ENUM(NSInteger, DKTargetStatus){
    DKTargetStatus_Doing,
    DKTargetStatus_Cancel,
    DKTargetStatus_Finished,
};

@interface DKTargetModel : NSObject

@property (nonatomic, copy  ) NSString *uniqueId;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *backgroundImage;

/// 目标签到数据
@property (nonatomic, strong) NSMutableArray <DKSignModel *>*signModels;
/// 频次设置
@property (nonatomic, assign) DKTargetPinCiType pinciType;
/// 固定周几
@property (nonatomic, strong) NSMutableArray <DKTargetPinCiWeekModel *> *weekSettings;
/// 每周几次
@property (nonatomic, assign) NSInteger weekofDay;
/// 每月几次
@property (nonatomic, assign) NSInteger monthOfDay;

/// 开始时间
@property (nonatomic, strong) NSDate *startDate;
/// 结束时间
@property (nonatomic, strong) NSDate *endDate;
/// 任务状态
@property (nonatomic, assign) DKTargetStatus status;


- (BOOL) isSignByDate:(NSDate *)date;

/// 目标次数
- (NSInteger) targetCount;

/// 连续次数
- (NSInteger) continueCont;
@end


@interface DKTargetPinCiWeekModel : NSObject

@property (nonatomic, copy  ) NSString *weekName;
@property (nonatomic, assign) NSInteger weekday;
@property (nonatomic, assign) BOOL isSelected;
- (BOOL) isToday;
@end
