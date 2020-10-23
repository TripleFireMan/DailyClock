//
//  DKTargetDetailViewController.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/13.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  目标详情页

#import "DKTargetDetailViewController.h"
#import "FSCalendar.h"
#import "DKDetailAnalyticsView.h"
#import "DKTargetSettingViewController.h"
#import "DKDailyArticleView.h"
#import "DailyClock-Swift.h"

@interface DKTargetDetailViewController ()<FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView *calendarContainer;
@property (nonatomic, strong) FSCalendar    *calendar;

@property (nonatomic, strong) UIImageView *redPoint;
@property (nonatomic, strong) UILabel *analyticsLabel;
@property (nonatomic, strong) DKDailyArticleView *articleView;
@property (nonatomic, strong) DKDetailAnalyticsView *l1;
@property (nonatomic, strong) DKDetailAnalyticsView *l2;
@property (nonatomic, strong) DKDetailAnalyticsView *l3;
@property (nonatomic, strong) DKDetailAnalyticsView *l4;

@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *activeBtn;


@end

@implementation DKTargetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldShowBackBtn = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self p_config];
}

- (void) p_config{
    
    self.title = self.model.title ?:@"目标详情";
    // Do any additional setup after loading the view.
    NSArray *selectedDates = [[self.model signModels] valueForKeyPath:@"date"];
    [selectedDates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.calendar selectDate:obj];
    }];
    
    NSMutableAttributedString *l1txt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   天",@(self.model.signModels.count)]];
    
    NSMutableAttributedString *l2txt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   天",@(self.model.continueCont)]];
    
    NSInteger targetCount = self.model.targetCount-self.model.signModels.count;
    if (targetCount < 0) {
        targetCount = 0;
    }
    NSMutableAttributedString *l3txt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld  天",targetCount]];
    
    NSMutableAttributedString *l4txt = [[NSMutableAttributedString alloc] initWithString:[[self.model createDate] stringWithFormat:@"yyyy.MM.dd"]];
    
    [l1txt setFont:DKBoldFont(13)];
    [l1txt setFont:CYBebas(20) range:NSMakeRange(0, l1txt.rangeOfAll.length-1)];
    
    [l2txt setFont:DKBoldFont(13)];
    [l2txt setFont:CYBebas(20) range:NSMakeRange(0, l2txt.rangeOfAll.length-1)];
    
    [l3txt setFont:DKBoldFont(13)];
    [l3txt setFont:CYBebas(20) range:NSMakeRange(0, l3txt.rangeOfAll.length-1)];
    
    
    [l4txt setFont:CYBebas(15)];
    
    self.l1.titleLabel.attributedText = l1txt;
    self.l2.titleLabel.attributedText = l2txt;
    self.l3.titleLabel.attributedText = l3txt;
    self.l4.titleLabel.attributedText = l4txt;
    
    if (self.model.status == DKTargetStatus_Doing) {
        self.activeBtn.hidden = YES;
        self.stopBtn.hidden = NO;
    }
    else if (self.model.status == DKTargetStatus_Cancel){
        self.stopBtn.hidden = YES;
        self.activeBtn.hidden = NO;
    }
    [self.articleView configModel:self.model];
}

- (void) setupSubView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.calendarContainer];
    [self.calendarContainer addSubview:self.calendar];
    [self.scrollView addSubview:self.articleView];
    [self.scrollView addSubview:self.redPoint];
    [self.scrollView addSubview:self.analyticsLabel];
    [self.scrollView addSubview:self.l1];
    [self.scrollView addSubview:self.l2];
    [self.scrollView addSubview:self.l3];
    [self.scrollView addSubview:self.l4];
    [self.scrollView addSubview:self.activeBtn];
    [self.scrollView addSubview:self.stopBtn];
    [self.scrollView addSubview:self.editBtn];
    [self.scrollView addSubview:self.deleteBtn];
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
    
    [self.articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(self.calendarContainer.mas_bottom).offset(0);
    }];
    
    [self.redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.height.offset(8);
        make.top.mas_equalTo(self.articleView.mas_bottom).offset(15);
    }];
    
    [self.analyticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.redPoint.mas_right).offset(10);
        make.centerY.mas_equalTo(self.redPoint);
    }];
    
    CGFloat itemWidth = (kScreenSize.width - 40) /2.f;
    CGFloat itemHeigt = 100;
    
    [self.l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.mas_equalTo(self.analyticsLabel.mas_bottom).offset(20);
        make.width.offset(itemWidth);
        make.height.offset(itemHeigt);
    }];
    
    [self.l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.mas_equalTo(self.analyticsLabel.mas_bottom).offset(20);
        make.width.offset(itemWidth);
        make.height.offset(itemHeigt);
    }];
    
    [self.l3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.mas_equalTo(self.l1.mas_bottom).offset(20);
        make.width.offset(itemWidth);
        make.height.offset(itemHeigt);
    }];
    
    [self.l4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.mas_equalTo(self.l1.mas_bottom).offset(20);
        make.width.offset(itemWidth);
        make.height.offset(itemHeigt);
    }];
    
    CGFloat btnwidth = (kScreenSize.width -50) / 3.f;
    CGFloat btnHeight = 44.f;
    
    [self.stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.l3.mas_bottom).offset(30);
        make.top.mas_equalTo(self.l3.mas_bottom).offset(30);
        make.left.offset(15);
        make.width.offset(btnwidth);
        make.height.offset(btnHeight);
        make.bottom.offset(-CY_Height_Bottom_SafeArea-20);
    }];

    [self.activeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.l3.mas_bottom).offset(30);
        make.top.mas_equalTo(self.l3.mas_bottom).offset(30);
        make.left.offset(15);
        make.width.offset(btnwidth);
        make.height.offset(btnHeight);
        make.bottom.offset(-CY_Height_Bottom_SafeArea-20);
    }];
    
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.stopBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(self.stopBtn);
        make.width.offset(btnwidth);
        make.height.offset(btnHeight);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.editBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(self.stopBtn);
        make.width.offset(btnwidth);
        make.height.offset(btnHeight);
    }];
}

- (UIScrollView *) scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIView *) calendarContainer{
    if (!_calendarContainer) {
        _calendarContainer = [UIView new];
        _calendarContainer.backgroundColor = DKIOS13ContainerColor();
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
        
        if (@available(iOS 13, *)) {
            _calendar.appearance.headerTitleColor = [UIColor labelColor];
            _calendar.appearance.weekdayTextColor = [UIColor labelColor];
            _calendar.appearance.borderSelectionColor = [UIColor labelColor];
            _calendar.appearance.borderDefaultColor = kMainColor;
        } else {
            _calendar.appearance.headerTitleColor = [UIColor blackColor];
            _calendar.appearance.weekdayTextColor = [UIColor blackColor];
            _calendar.appearance.borderDefaultColor = kMainColor;
            _calendar.appearance.borderSelectionColor = [UIColor blackColor];
        }

        
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
        
        [DKAlert showTitle:@"提示" subTitle:@"您是否要补卡？" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
            if (idx == DKAlertDone) {
                DKSignModel *signModel = [DKSignModel new];
                signModel.date = date;
                [self.model.signModels addObject:signModel];
                [self p_config];
                [[DKTargetManager cy_shareInstance] cy_save];
            }
        } doneTitle:@"确定" array:@[@"取消"]];
        
        return NO;
    }
}

- (BOOL) calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    __block BOOL dateIsDaka = NO;
    __block DKSignModel *findObj = nil;
    [self.model.signModels enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isSameDay:date date2:obj.date]) {
            dateIsDaka = YES;
            findObj = obj;
            *stop = YES;
        }
    }];
    
    if (dateIsDaka) {
        [DKAlert showTitle:@"提示" subTitle:@"确定取消打卡,取消打卡后，日志信息也会删除？" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
            if (idx == DKAlertDone) {
                [self.model.signModels removeObject:findObj];
                [self.calendar deselectDate:findObj.date];
                [self p_config];
                [[DKTargetManager cy_shareInstance] cy_save];
            }
        } doneTitle:@"确定" array:@[@"取消"]];
    }
    
    return NO;
}



- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

- (DKDetailAnalyticsView *) l1{
    if (!_l1) {
        _l1 = [DKDetailAnalyticsView new];
        _l1.subtitleLabel.text = @"已打卡";
        _l1.layer.cornerRadius = 12.f;
        
        
        
    }
    return _l1;
}

- (DKDetailAnalyticsView *) l2{
    if (!_l2) {
        _l2 = [DKDetailAnalyticsView new];
        _l2.subtitleLabel.text = @"当前连续打卡";
        _l2.layer.cornerRadius = 12.f;
    }
    return _l2;
}

- (DKDetailAnalyticsView *) l3{
    if (!_l3) {
        _l3 = [DKDetailAnalyticsView new];
        _l3.subtitleLabel.text = @"距离目标";
        _l3.layer.cornerRadius = 12.f;
    }
    return _l3;
}

- (DKDetailAnalyticsView *) l4{
    if (!_l4) {
        _l4 = [DKDetailAnalyticsView new];
        _l4.subtitleLabel.text = @"建立日期";
        _l4.layer.cornerRadius = 12.f;
    }
    return _l4;
}

- (DKDailyArticleView *) articleView{
    @weakify(self);
    if (!_articleView) {
        _articleView = [DKDailyArticleView new];
        _articleView.checkMoreAction = ^{
            @strongify(self);
            DKDailyListViewController *list = [DKDailyListViewController new];
            list.data = self.model;
            [self.navigationController pushViewController:list animated:YES];
        };
    }
    return _articleView;
}

- (UIImageView *) redPoint{
    if (!_redPoint) {
        _redPoint = [UIImageView new];
        _redPoint.backgroundColor = [UIColor redColor];
        _redPoint.layer.cornerRadius = 4.f;
        _redPoint.layer.masksToBounds = YES;
    }
    return _redPoint;
}


- (UILabel *) analyticsLabel{
    if (!_analyticsLabel) {
        _analyticsLabel = [UILabel new];
        _analyticsLabel.font = DKBoldFont(18);
        if (@available(iOS 13.0, *)) {
            _analyticsLabel.textColor = [UIColor labelColor];
        } else {
            // Fallback on earlier versions
            _analyticsLabel.textColor = [UIColor blackColor];
        }
        _analyticsLabel.text = @"打卡统计";
    }
    return _analyticsLabel;
}


- (UIButton *) activeBtn{
    @weakify(self);
    if (!_activeBtn) {
        _activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_activeBtn setTitle:@"激活" forState:UIControlStateNormal];
        _activeBtn.titleLabel.font = DKFont(15);
        _activeBtn.backgroundColor = RGBColor(59, 214, 224);
        _activeBtn.layer.cornerRadius = 22.f;
        [[_activeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
            self.model.status = DKTargetStatus_Doing;
            [[DKTargetManager cy_shareInstance] cy_save];
            [self p_config];
            [XHToast showBottomWithText:@"任务已激活"];
        }];
            
    }
    return _activeBtn;
}


- (UIButton *) stopBtn{
    @weakify(self);
    if (!_stopBtn) {
        _stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopBtn setTitle:@"结束" forState:UIControlStateNormal];
        _stopBtn.titleLabel.font = DKFont(15);
        _stopBtn.backgroundColor = RGBColor(220, 220, 220);
        _stopBtn.layer.cornerRadius = 22.f;
        [[_stopBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [DKAlert showTitle:@"提示" subTitle:@"您将暂停该目标，暂停后，可从个人中心恢复" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
                if (idx == DKAlertDone) {
                    self.model.status = DKTargetStatus_Cancel;
                    [[DKTargetManager cy_shareInstance] cy_save];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } doneTitle:@"确定" array:@[@"取消"]];
        }];
        
    }
    return _stopBtn;
}

- (UIButton *) editBtn{
    @weakify(self);
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = DKFont(15);
        _editBtn.layer.cornerRadius = 22.f;
        _editBtn.backgroundColor = RGBColor(249, 216, 135);
        [[_editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            DKTargetSettingViewController *vc = [DKTargetSettingViewController initWithTargetType:DKTargetSettingType_Modifier model:self.model];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _editBtn;
}

- (UIButton *) deleteBtn{
    @weakify(self);
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = 22.f;
        _deleteBtn.titleLabel.font = DKFont(15);
        _deleteBtn.backgroundColor = RGBColor(255, 91, 96);
        [[_deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [DKAlert showTitle:@"提示" subTitle:@"您将永久删除此目标，删除后不可恢复" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
                if (idx == DKAlertDone) {
                    [[DKTargetManager cy_shareInstance] removeTarget:self.model];
                    [[DKTargetManager cy_shareInstance] cy_save];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } doneTitle:@"确定" array:@[@"取消"]];
            
        }];
    }
    return _deleteBtn;
}






@end










