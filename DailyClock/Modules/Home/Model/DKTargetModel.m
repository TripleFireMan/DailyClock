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
        NSString *weekInfo = [self getWeekTime];
        NSString *zhouyi = [[weekInfo componentsSeparatedByString:@"-"] firstObject];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.dateFormat = @"YYYY年MM月dd日";
        NSDate *zhouyiDate = [formater dateFromString:zhouyi];
        for (int i = 0; i < 7; i++) {
            DKTargetPinCiWeekModel *weekModel = [DKTargetPinCiWeekModel new];
            weekModel.isSelected = YES;
            weekModel.weekday = i+2;
            weekModel.date = [zhouyiDate dateByAddingDays:i];
            if (i==6) {
                weekModel.weekday = 1;
            }
            weekModel.weekName = weekNames[i];
            [_weekSettings addObject:weekModel];
        }
    }
    
    NSString *weekInfo = [self getWeekTime];
    NSString *zhouyi = [[weekInfo componentsSeparatedByString:@"-"] firstObject];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"YYYY年MM月dd日";
    NSDate *zhouyiDate = [formater dateFromString:zhouyi];
    
    [_weekSettings enumerateObjectsUsingBlock:^(DKTargetPinCiWeekModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.date = [zhouyiDate dateByAddingDays:idx];
    }];
    
    
    return _weekSettings;
}

- (NSString *)getWeekTime
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    NSLog(@"%ld----%ld",(long)weekDay,(long)day);

    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1; weekDay == 1 == 周日
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *baseDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];

    //获取周一日期
    [baseDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:baseDayComp];
    
    //获取周末日期
    [baseDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:baseDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    NSLog(@"%@=======%@",firstDay,lastDay);
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];
    
    return dateStr;
    
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
    
    
//    NSArray <NSDate *>* dates = [self.signModels valueForKeyPath:@"date"];
    NSArray * signModels = [self.signModels sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
    NSArray * dates = [signModels valueForKeyPath:@"date"];
    __block NSDate *day = [dates firstObject];
    
    [dates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isToday] || [obj isYesterday]) {
            count++;
        }
        else{
            if ([self isContinueDay:day date2:obj] == 1) {
                count++;
                
            }
            else{
                *stop = YES;
            }
        }
        day = obj;
    }];
    
    return count;
}

- (NSInteger)isContinueDay:(NSDate *)date1 date2:(NSDate *)date2{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *com = [calendar components:unitFlag fromDate:date1 toDate:date2 options:NSCalendarWrapComponents];
    NSInteger days = labs([com day]);
    return days;
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

