//
//Created by ESJsonFormatForMac on 20/09/03.
//

#import "DKTargetModel.h"
@implementation DKTargetModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
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
            weekModel.weekday = i;
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

@end

@implementation DKTargetPinCiWeekModel

- (BOOL) isToday{
    if (self.weekday == [NSDate date].weekdayOrdinal) {
        return YES;
    }
    return NO;
}
@end

