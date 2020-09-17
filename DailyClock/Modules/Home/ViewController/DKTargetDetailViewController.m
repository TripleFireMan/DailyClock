//
//  DKTargetDetailViewController.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/13.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  目标详情页

#import "DKTargetDetailViewController.h"
#import "FSCalendar.h"

@interface DKTargetDetailViewController ()<FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView *calendarContainer;
@property (nonatomic, strong) FSCalendar    *calendar;

@end

@implementation DKTargetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldShowBackBtn = YES;
    self.shouldShowBottomLine = YES;
    self.backBtn.tintColor = kThemeGray;
    self.title = self.model.title ?:@"目标详情";
    // Do any additional setup after loading the view.
    NSArray *selectedDates = [[self.model signModels] valueForKeyPath:@"date"];
    [selectedDates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.calendar selectDate:obj];
    }];
}

- (void) setupSubView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.calendarContainer];
    [self.calendarContainer addSubview:self.calendar];
}

- (void) addConstraints{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenSize.width);
        make.height.offset(kScreenSize.height - CY_Height_NavBar);
        make.edges.insets(UIEdgeInsetsMake(CY_Height_NavBar, 0, 0, 0));
    }];
    
    [self.calendarContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(kScreenSize.width - 30);
        make.right.offset(-15);
        make.top.offset(15);
        make.height.offset(310);
    }];
//    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.offset(300);
//    }];
}

- (UIScrollView *) scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UIView *) calendarContainer{
    if (!_calendarContainer) {
        _calendarContainer = [UIView new];
        _calendarContainer.backgroundColor = kContainerColor;
        _calendarContainer.layer.cornerRadius = 12.f;
    }
    return _calendarContainer;
}

- (FSCalendar *) calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(15, 15, kScreenSize.width-50, 280)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.firstWeekday = 2;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
        _calendar.backgroundColor = [UIColor clearColor];
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        _calendar.appearance.weekdayTextColor = [UIColor blackColor];
        _calendar.appearance.borderDefaultColor = kMainColor;
        _calendar.appearance.borderSelectionColor = [UIColor blackColor];
        
        _calendar.appearance.titleFont = DKFont(FSCalendarStandardTitleTextSize);
        _calendar.appearance.subtitleFont = DKFont(FSCalendarStandardSubtitleTextSize);
        _calendar.appearance.weekdayFont = DKFont(FSCalendarStandardWeekdayTextSize);
        _calendar.appearance.headerTitleFont = DKFont(FSCalendarStandardHeaderTextSize);
        
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        _calendar.allowsMultipleSelection = YES;
    }
    return _calendar;
}
/**
 * Asks the dataSource for a title for the specific date as a replacement of the day text
 */

/**
 * Asks the dataSource for a subtitle for the specific date under the day text.
 */
- (nullable NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date{
    if ([date isToday]) {
        return @"今";
    }
    else{
        return nil;
    }
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date{
    if ([date timeIntervalSinceNow] > 0 && ![date isToday]) {
        return kFutureContainerColor;
    }
    else{
        if ([date isToday]) {
            return [UIColor redColor];
        }
        else{
            return kDefaultContainerColor;
        }
    }
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date{
    
    if ([date timeIntervalSinceNow] > 0 && ![date isToday]) {
        return kFutureContainerBorderColor;
    }
    else{
        if ([date isToday]) {
            return [UIColor clearColor];
        }
        else{
            return kDefaultContainerBorderColor;
        }
    }
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
    
    if ([date timeIntervalSinceNow] > 0 && ![date isToday]) {
        return kFutureContainerTitleColor;
    }
    else{
        if ([date isToday]) {
            return [UIColor whiteColor];
        }
        else{
            return kDefaultContainerTitleColor;
        }
    }
    
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date{
    return [UIColor whiteColor];
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date{
    return kSelectedContainerColor;
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date{
    return kSelectedContainerTitleColor;
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date{
    return kSelectedContainerBorderColor;
}

- (UIColor *) calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(NSDate *)date{
    return kSelectedContainerTitleColor;
}

- (BOOL) calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    if ([date timeIntervalSinceNow] > 0 && ![date isToday]) {
        return NO;
    }
    else{
        return YES;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end










