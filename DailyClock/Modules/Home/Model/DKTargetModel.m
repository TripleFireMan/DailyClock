//
//Created by ESJsonFormatForMac on 20/09/03.
//

#import "DKTargetModel.h"
@implementation DKTargetModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

- (id) init{
    self = [super init];
    if (self) {
        self.shouldAutoDaily = YES;
    }
    return self;
}

- (NSString *) uniqueId{
    if (!_uniqueId) {
        CFStringRef uuidString =  CFUUIDCreateString(NULL,CFUUIDCreate(NULL));
        _uniqueId = (__bridge NSString *) uuidString;
    }
    return _uniqueId;
}

- (NSMutableArray <DKSignModel *> *)signModels{
    if (!_signModels) {
        _signModels = [NSMutableArray array];
    }
    return _signModels;
}

- (NSMutableArray <DKTargetPinCiWeekModel *> *) weekSettings{
    if (!_weekSettings) {
        _weekSettings = [NSMutableArray array];
        NSArray *weekNames = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        for (int i = 0; i < 7; i++) {
            DKTargetPinCiWeekModel *weekModel = [DKTargetPinCiWeekModel new];
            weekModel.isSelected = YES;
            weekModel.weekday = i+2;
            if (i==6) {
                weekModel.weekday = 1;
            }
            weekModel.weekName = weekNames[i];
            [_weekSettings addObject:weekModel];
        }
    }
    return _weekSettings;
}

- (NSDate *) startDate{
    if (!_startDate) {
        _startDate = [NSDate date];
    }
    return _startDate;
}


- (NSDate *) createDate{
    if (!_createDate) {
        _createDate = [NSDate date];
    }
    return _createDate;
}

- (NSDate *) endDate{
    if (!_endDate) {
        _endDate = [[NSDate date] dateByAddingMonths:1];
    }
    return _endDate;
}


- (BOOL) isSignByDate:(NSDate *)date{
    __block BOOL isSign = NO;
    [self.signModels enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.date.day == date.day) {
            isSign = YES;
//            *stop = YES;
        }
    }];
    return isSign;
}

- (NSInteger) targetCount{
    NSInteger targetCount = 0;
    NSInteger totalDays = [self.endDate timeIntervalSinceDate:self.startDate] / (60*24*60.f);
    __block NSInteger gudingDays = 0;
    [self.weekSettings enumerateObjectsUsingBlock:^(DKTargetPinCiWeekModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            gudingDays++;
        }
    }];
    
    switch (self.pinciType) {
        case DKTargetPinCiType_Guding:
        {
            targetCount = totalDays *gudingDays/7.f;
        }
            break;
        case DKTargetPinCiType_Week:
        {
            targetCount = self.weekofDay * totalDays / 7.f;
        }
            break;
        case DKTargetPinCiType_Month:
        {
            targetCount = self.monthOfDay * totalDays / 30.f;
        }
            break;;
        default:
            break;
    }
    if (targetCount != 0) {
        targetCount ++;
    }
    return targetCount;
}

- (NSInteger) continueCont{

    __block NSInteger count = 0;
    __block NSDate *day = [self.signModels lastObject].date;
    
    [[[self.signModels reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.date isToday] || [obj.date isYesterday]) {
            count++;
        }
        else{
            if ([day timeIntervalSinceDate:obj.date] > 24 * 60 * 60) {
                *stop = YES;
            }
            else{
                count++;
            }
        }
        day = obj.date;
    }];
    
    return count;
}


@end

@implementation DKTargetPinCiWeekModel

- (BOOL) isToday{
    if (self.weekday == [NSDate date].weekday) {
        return YES;
    }
    return NO;
}
@end

