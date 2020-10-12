//
//
//  Created by 成焱 on 2020/9/4.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetSettingViewController.h"
#import "DKPingCiSettingView.h"
#import "DKDateSelectView.h"
#import "DKDailyArticleReminderView.h"
#import "DKDailyClockTimeSettingView.h"

@interface DKTargetSettingViewController ()
/// 内容区
@property (nonatomic, strong) UIScrollView *scrollView;

/// 目标名称设置
@property (nonatomic, strong) UIView        *nameContainer;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIView        *nameMaskView;
@property (nonatomic, strong) UITextField   *nameTF;
@property (nonatomic, strong) UIView        *nameBlank;

/// 起止时间设置
@property (nonatomic, strong) UIView    *timeContainer;
@property (nonatomic, strong) UILabel   *timeLabel;

@property (nonatomic, strong) UIView    *timeMaskView;
@property (nonatomic, strong) UILabel   *startTimeLabel;
@property (nonatomic, strong) UIButton  *startTimeBtn;
@property (nonatomic, strong) UILabel   *endTimeLabel;
@property (nonatomic, strong) UIButton  *endTimeBtn;
@property (nonatomic, strong) UIView    *timeBlank;
@property (nonatomic, strong) UILabel   *totalDays;

/// 频次设置
@property (nonatomic, strong) UIView    *pingciContainer;
@property (nonatomic, strong) UILabel   *pingciLabel;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) DKPingCiSettingView *pingciSettingView;
@property (nonatomic, strong) UIView    *pingciBlank;

/// 日志弹出开关
@property (nonatomic, strong) UIView    *rizhiContainer;
@property (nonatomic, strong) UILabel   *rizhiLabel;
@property (nonatomic, strong) UILabel   *rizhiTextLabel;
@property (nonatomic, strong) UISwitch  *rizhiSwitch;
@property (nonatomic, strong) UIView    *rizhiBlank;

/// 页面创建的目标对象
@property (nonatomic, strong) DKTargetModel *model;

@property (nonatomic, strong) UIButton  *saveBtn;

@property (nonatomic, strong) DKDailyArticleReminderView *reminderView;

@end

@implementation DKTargetSettingViewController

#pragma mark - def
- (void) dealloc{
    /// 页面消失的时候，需要将提醒信息清空
    _targetModel.reminders = nil;
}
#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    self.titleLabel.text = self.editModel? @"编辑目标": @"设置目标";
    self.shouldShowBackBtn = YES;
    
    if (self.editModel) {
        self.model = self.editModel;
        self.nameTF.text = self.model.title;
        [self.reminderView configModel:self.model];
    }
    else{
        if (self.targetModel.ID != 0) {
            self.nameTF.text = self.targetModel.title;
        }
    }
    
    [RACObserve(self.segment, selectedSegmentIndex) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger type = [x integerValue];
        self.model.pinciType = type;
    }];
    
    
}

- (void) backbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setupSubView
{
    [self.view addSubview:self.scrollView];
    [self.headerView addSubview:self.saveBtn];
    [self.scrollView addSubview:self.nameContainer];
    [self.nameContainer addSubview:self.nameLabel];
    [self.nameContainer addSubview:self.nameMaskView];
    [self.nameMaskView addSubview:self.nameTF];
    [self.nameContainer addSubview:self.nameBlank];
    
    [self.scrollView addSubview:self.timeContainer];
    [self.timeContainer addSubview:self.timeMaskView];
    [self.timeContainer addSubview:self.totalDays];
    [self.timeContainer addSubview:self.timeLabel];
    [self.timeMaskView addSubview:self.startTimeLabel];
    [self.timeMaskView addSubview:self.endTimeLabel];
    [self.timeMaskView addSubview:self.startTimeBtn];
    [self.timeMaskView addSubview:self.endTimeBtn];
    [self.timeContainer addSubview:self.timeBlank];
    
    [self.scrollView addSubview:self.reminderView];
    
    [self.scrollView addSubview:self.pingciContainer];
    [self.pingciContainer addSubview:self.pingciLabel];
    [self.pingciContainer addSubview:self.segment];
    [self.pingciContainer addSubview:self.pingciSettingView];
    [self.pingciContainer addSubview:self.pingciBlank];
    
    [self.scrollView addSubview:self.rizhiContainer];
    [self.rizhiContainer addSubview:self.rizhiLabel];
    [self.rizhiContainer addSubview:self.rizhiTextLabel];
    [self.rizhiContainer addSubview:self.rizhiSwitch];
    [self.rizhiContainer addSubview:self.rizhiBlank];
}

- (void) addConstraints
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.height.offset(44);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    
    [self.nameContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.width.offset(kScreenSize.width);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(20);
    }];
    
    [self.nameMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(15);
        make.bottom.offset(-15);
        make.height.offset(30);
        make.right.offset(-10);
    }];
    
    [self.nameBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(10);
        make.top.mas_equalTo(self.nameMaskView.mas_bottom).offset(20);
    }];
    
    [self.timeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.nameContainer.mas_bottom).offset(0);
    }];
    
    [self.totalDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.timeLabel);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    [self.timeMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(15);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTimeLabel.mas_bottom).offset(15);
        make.left.offset(10);
        make.bottom.offset(-15);
    }];
    
    [self.startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.startTimeLabel);
    }];
    
    [self.endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.endTimeLabel);
    }];
    
    [self.timeBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeMaskView.mas_bottom).offset(20);
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.height.offset(10);
    }];
    
    [self.reminderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.timeContainer.mas_bottom);
//        make.height.offset(200);
    }];
    
    [self.pingciContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.reminderView.mas_bottom);
    }];
    
    [self.pingciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    [self.pingciSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pingciLabel.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(80);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.pingciLabel);
    }];
    
    [self.pingciBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.pingciSettingView.mas_bottom).offset(0);
        make.height.offset(10);
        make.bottom.offset(0);
    }];
    
    [self.rizhiContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.mas_equalTo(self.pingciContainer.mas_bottom).offset(0);
        make.bottom.offset(0);
    }];

    [self.rizhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    [self.rizhiTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.mas_equalTo(self.rizhiLabel.mas_bottom).offset(20);
        
    }];
    
    [self.rizhiSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.rizhiTextLabel);
    }];
    
    [self.rizhiBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rizhiTextLabel.mas_bottom).offset(20);
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.height.offset(10);
    }];
    
}

#pragma mark - api

#pragma mark - model event

- (void) setTargetModel:(DKTargetModel *)targetModel{
    _targetModel = targetModel;
    self.model.title = _targetModel.title;
    self.model.icon = _targetModel.icon;
    self.model.backgroundImage = _targetModel.backgroundImage;
    self.model.ID = _targetModel.ID;
    [self.reminderView configModel:_targetModel];
}
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

- (UIButton *)saveBtn{
    @weakify(self);
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = DKFont(16.f);
        [_saveBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        [_saveBtn setTitleColor:DKIOS13SecondLabelColor() forState:UIControlStateHighlighted];
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (CYStringIsEmpty(self.nameTF.text)) {
                [XHToast showBottomWithText:@"请设置目标名称"];
                return;
            }
            self.model.title = self.nameTF.text;
            [[DKTargetManager cy_shareInstance] addTarget:self.model];
            NSMutableArray *vcs = [self.navigationController viewControllers].mutableCopy;
            NSMutableArray *willremove = @[].mutableCopy;
            [vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([NSStringFromClass([obj class]) isEqualToString:@"DKCreateTargetViewController"]) {
                    [willremove addObject:obj];
                }
            }];
            [vcs removeObjectsInArray:willremove];
            [self.navigationController setViewControllers:vcs animated:NO];
            [self.navigationController popViewControllerAnimated:YES];
            [[DKTargetManager cy_shareInstance] cy_save];
        }];
    }
    return _saveBtn;
}
- (UIScrollView *) scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView .alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIView *) nameContainer{
    if (!_nameContainer) {
        _nameContainer = [UIView new];
//        _nameContainer.backgroundColor = [UIColor whiteColor];
    }
    return _nameContainer;
}

- (UILabel *) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = DKFont(16);
        if (@available(iOS 13, *)) {
            _nameLabel.textColor = [UIColor labelColor];
        } else {
            _nameLabel.textColor = [UIColor blackColor];
        }
        
        _nameLabel.text = @"目标名称";
    }
    return _nameLabel;
}

- (UIView *) nameMaskView{
    if (!_nameMaskView) {
        _nameMaskView = [UIView new];
        _nameMaskView.layer.cornerRadius = 6.f;
        _nameMaskView.backgroundColor = DKIOS13BackgroundColor();
        
        _nameMaskView.layer.masksToBounds = YES;
        
    }
    return _nameMaskView;
}

- (UITextField *) nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.font = DKFont(14.f);
        _nameTF.textColor = DKIOS13LabelColor();
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"起一个能坚持下来的名字吧~"];
        placeholder.font = DKFont(14.f);
        if (@available(iOS 13, *)) {
            placeholder.color = [UIColor labelColor];
        } else {
            placeholder.color = RGBColor(195, 196, 192);
        }
        
        _nameTF.attributedPlaceholder = placeholder;
    }
    return _nameTF;
}

- (UIView *) nameBlank{
    if (!_nameBlank) {
        _nameBlank = [UIView new];
        _nameBlank.backgroundColor = DKIOS13BackgroundColor();
    }
    return _nameBlank;
}



- (UIView *) timeContainer{
    if (!_timeContainer) {
        _timeContainer = [UIView new];
        
    }
    return _timeContainer;
}

- (UIView *) timeMaskView{
    if (!_timeMaskView) {
        _timeMaskView = [UIView new];
        _timeMaskView.layer.cornerRadius = 6.f;
        _timeMaskView.layer.masksToBounds = YES;
        _timeMaskView.backgroundColor = DKIOS13BackgroundColor();
    }
    return _timeMaskView;
}

- (UILabel *) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = DKFont(16);
        if (@available(iOS 13, *)) {
            _timeLabel.textColor = [UIColor labelColor];
        } else {
            _timeLabel.textColor = [UIColor blackColor];
        }
        _timeLabel.text = @"起止时间";
    }
    return _timeLabel;
}

- (UILabel *) startTimeLabel{
    if (!_startTimeLabel) {
        _startTimeLabel = [UILabel new];
        _startTimeLabel.font = DKFont(12);
        if (@available(iOS 13, *)) {
            _startTimeLabel.textColor = [UIColor labelColor];
        } else {
            _startTimeLabel.textColor = [UIColor blackColor];
        }
        _startTimeLabel.text = @"开始时间";
    }
    return _startTimeLabel;
}

- (UILabel *) endTimeLabel{
    if (!_endTimeLabel) {
        _endTimeLabel = [UILabel new];
        _endTimeLabel.font = DKFont(12);
        if (@available(iOS 13, *)) {
            _endTimeLabel.textColor = [UIColor labelColor];
        } else {
            _endTimeLabel.textColor = [UIColor blackColor];
        }
        _endTimeLabel.text = @"结束时间";
    }
    return _endTimeLabel;
}

- (UILabel *) totalDays{
    if (!_totalDays) {
        _totalDays = [UILabel new];
        _totalDays.font = DKFont(14);
        _totalDays.textColor = [UIColor blackColor];
        if (@available(iOS 13, *)) {
            _totalDays.textColor = [UIColor labelColor];
        } else {
            _totalDays.textColor = [UIColor blackColor];
        }
        [self p_configTotalInfo];
    }
    return _totalDays;
}

- (UIButton *) startTimeBtn{
    @weakify(self);
    if (!_startTimeBtn) {
        _startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (@available(iOS 13, *)) {
            [_startTimeBtn setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
        } else {
            [_startTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        _startTimeBtn.titleLabel.font = DKFont(12.f);
        [_startTimeBtn setTitle:[self stringWithDate:self.model.startDate] forState:UIControlStateNormal];
        [[_startTimeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            DKDateSelectView *selectedView = [DKDateSelectView showOnView:self.view animated:YES];
            selectedView.confirmBlock = ^(id obj) {
                NSDate *date = obj;
                NSString *dateStrinng = [self stringWithDate:date];
                
                if ([date timeIntervalSinceDate:self.model.endDate] <= 0) {
                    self.model.startDate = date;
                    [self.startTimeBtn setTitle:dateStrinng forState:UIControlStateNormal];
                }
                else{
                    self.model.startDate = self.model.endDate;
                    [self.startTimeBtn setTitle:[self stringWithDate:self.model.startDate] forState:UIControlStateNormal];
                    [XHToast showBottomWithText:@"开始时间不可大于结束时间"];
                }
                [self p_configTotalInfo];
            };
            selectedView.date = self.model.startDate;
        }];
    }
    return _startTimeBtn;
}

- (void) p_configTotalInfo{
    NSInteger days = [[self.model endDate] timeIntervalSinceDate:self.model.startDate]/ (24* 60*60.f) + 1;
    self.totalDays.text = [NSString stringWithFormat:@"共 %@ 天",@(days)];
}

- (UIButton *) endTimeBtn{
    @weakify(self);
    if (!_endTimeBtn) {
        _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (@available(iOS 13, *)) {
            [_endTimeBtn setTitleColor:[UIColor labelColor] forState:UIControlStateNormal];
        } else {
            [_endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        _endTimeBtn.titleLabel.font = DKFont(12.f);
        [_endTimeBtn setTitle:[self stringWithDate:self.model.endDate] forState:UIControlStateNormal];
        [[_endTimeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            DKDateSelectView *selectedView = [DKDateSelectView showOnView:self.view animated:YES];
            selectedView.confirmBlock = ^(id obj) {
                NSDate *date = obj;
                NSString *dateStrinng = [self stringWithDate:date];
                if ([date timeIntervalSinceDate:self.model.startDate] >= 0) {
                    self.model.endDate = date;
                    [self.endTimeBtn setTitle:dateStrinng forState:UIControlStateNormal];
                }
                else{
                    self.model.endDate = self.model.startDate;
                    [self.endTimeBtn setTitle:[self stringWithDate:self.model.endDate] forState:UIControlStateNormal];
                    [XHToast showBottomWithText:@"结束时间不可小于开始时间"];
                }
                [self p_configTotalInfo];
            };
            selectedView.date = self.model.endDate;
        }];
    }
    return _endTimeBtn;
}

- (UIView *) timeBlank{
    if (!_timeBlank) {
        _timeBlank = [UIView new];
        _timeBlank.backgroundColor = DKIOS13BackgroundColor();
    }
    return _timeBlank;
}

- (DKDailyArticleReminderView *)reminderView{
    @weakify(self);
    if (!_reminderView) {
        _reminderView = [DKDailyArticleReminderView new];
        _reminderView.block = ^(id obj) {
            @strongify(self);
            if ([obj isAdd]) {
                [DKDailyClockTimeSettingView showOnView:self.view model:self.model complete:^(id obj) {
                    DKReminder *reminder = (DKReminder *)obj;
                    if (self.editModel) {
                        [self.model.reminders addObject:reminder];
                    }
                    else{
                        [self.targetModel.reminders addObject:reminder];
                    }
                    [self.reminderView reload];
                }];
            }
            else{
                [DKAlert showTitle:@"提示" subTitle:@"确定要删除该提醒么" clickAction:^(NSInteger idx, NSString * _Nonnull idxTitle) {
                    if (idx == DKAlertDone) {
                        if (self.editModel) {
                            [self.model.reminders removeObject:obj];
                        }
                        else{
                            [self.targetModel.reminders removeObject:obj];
                        }
                        [self.reminderView reload];
                    }
                } doneTitle:@"确定" array:@[@"取消"]];
            }

        };
    }
    return _reminderView;
}

- (UIView *) pingciContainer{
    if (!_pingciContainer) {
        _pingciContainer = [UIView new];
    }
    return _pingciContainer;
}

- (UILabel *) pingciLabel{
    if (!_pingciLabel) {
        _pingciLabel = [UILabel new];
        _pingciLabel.text = @"目标频次";
        _pingciLabel.font = DKFont(16.f);
        if (@available(iOS 13, *)) {
            _pingciLabel.textColor = [UIColor labelColor];
        } else {
            _pingciLabel.textColor = [UIColor blackColor];
        }
    }
    return _pingciLabel;
}

- (DKPingCiSettingView *) pingciSettingView{
    if (!_pingciSettingView) {
        _pingciSettingView = [DKPingCiSettingView new];
        _pingciSettingView.model = self.editModel? : self.model;
    }
    return _pingciSettingView;
}

- (UIView *) pingciBlank{
    if (!_pingciBlank) {
        _pingciBlank = [UIView new];
        _pingciBlank.backgroundColor = DKIOS13BackgroundColor();
    }
    return _pingciBlank;
}

- (UIView *) rizhiContainer{
    if (!_rizhiContainer) {
        _rizhiContainer = [UIView new];
    }
    return _rizhiContainer;
}

- (UILabel *) rizhiLabel{
    if (!_rizhiLabel) {
        _rizhiLabel = [UILabel new];
        _rizhiLabel.font = DKFont(16.f);
        if (@available(iOS 13, *)) {
            _rizhiLabel.textColor = [UIColor labelColor];
        } else {
            _rizhiLabel.textColor = [UIColor blackColor];
        }
        _rizhiLabel.text = @"日志设置";
    }
    return _rizhiLabel;
}

- (UILabel *) rizhiTextLabel{
    if (!_rizhiTextLabel) {
        _rizhiTextLabel = [UILabel new];
        _rizhiTextLabel.font = DKFont(12);
        if (@available(iOS 13, *)) {
            _rizhiTextLabel.textColor = [UIColor secondaryLabelColor];
        } else {
            _rizhiTextLabel.textColor = [UIColor darkTextColor];
        }
        _rizhiTextLabel.text = @"是否自动弹出打卡日志";
    }
    return _rizhiTextLabel;
}

- (UISwitch *)rizhiSwitch{
    @weakify(self);
    if (!_rizhiSwitch) {
        _rizhiSwitch = [[UISwitch alloc] init];
        _rizhiSwitch.onTintColor = kMainColor;
        _rizhiSwitch.on = self.editModel?self.editModel.shouldAutoDaily:self.model.shouldAutoDaily;
        [[_rizhiSwitch rac_newOnChannel] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self);
            self.model.shouldAutoDaily = [x boolValue];
        }];
    }
    return _rizhiSwitch;
}

- (UIView *)rizhiBlank{
    if (!_rizhiBlank) {
        _rizhiBlank = [UIView new];
        _rizhiBlank.backgroundColor = DKIOS13BackgroundColor();
    }
    return _rizhiBlank;
}

- (UISegmentedControl *) segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"固定",@"每周",@"每月"]];
        _segment.selectedSegmentIndex = self.editModel?self.editModel.pinciType:0;
        _segment.tintColor = kContainerColor;
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        [_segment setTitleTextAttributes:@{NSFontAttributeName:DKFont(14)} forState:UIControlStateNormal];
    }
    return _segment;
}

- (DKTargetModel *) model{
    if (!_model) {
        _model = [DKTargetModel new];
    }
    return _model;
}

- (NSString *) stringWithDate:(NSDate *) date {
    if ([date isToday]) {
        return @"今天";
    }
    else{
        return [date stringWithFormat:@"yyyy-MM-dd"];
    }
}

#pragma mark -

@end
