//
//
//  Created by 成焱 on 2020/9/4.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetSettingViewController.h"
#import "DKPingCiSettingView.h"
#import "DKDateSelectView.h"

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

/// 页面创建的目标对象
@property (nonatomic, strong) DKTargetModel *model;

@property (nonatomic, strong) UIButton  *saveBtn;
@end

@implementation DKTargetSettingViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    @weakify(self);
    self.titleLabel.text = @"设置目标";
    self.shouldShowBackBtn = YES;
    self.backBtn.tintColor = kThemeGray;
    self.shouldShowBottomLine = YES;
    
    if (self.targetModel.ID != 0) {
        self.nameTF.text = self.targetModel.title;
    }
    
    [RACObserve(self.segment, selectedSegmentIndex) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger type = [x integerValue];
        self.model.pinciType = type;
    }];
    
    
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
    
    [self.scrollView addSubview:self.pingciContainer];
    [self.pingciContainer addSubview:self.pingciLabel];
    [self.pingciContainer addSubview:self.segment];
    [self.pingciContainer addSubview:self.pingciSettingView];
    [self.pingciContainer addSubview:self.pingciBlank];
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
    
    [self.pingciContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.timeContainer.mas_bottom);
    }];
    
    [self.pingciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(15);
    }];
    
    [self.pingciSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pingciLabel.mas_bottom).offset(15);
        make.left.right.offset(0);
        make.height.offset(100);
    }];
    
    [self.pingciBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.pingciSettingView.mas_bottom).offset(15);
        make.bottom.offset(0);
        make.height.offset(10);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.pingciLabel);
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
        _saveBtn.titleLabel.font = CYPingFangSCMedium(16.f);
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
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
        [_scrollView cy_adjustForIOS13];
        _scrollView .alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIView *) nameContainer{
    if (!_nameContainer) {
        _nameContainer = [UIView new];
        _nameContainer.backgroundColor = [UIColor whiteColor];
    }
    return _nameContainer;
}

- (UILabel *) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = CYPingFangSCMedium(16);
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"目标名称";
    }
    return _nameLabel;
}

- (UIView *) nameMaskView{
    if (!_nameMaskView) {
        _nameMaskView = [UIView new];
        _nameMaskView.layer.cornerRadius = 6.f;
        _nameMaskView.backgroundColor = kContainerColor;
        _nameMaskView.layer.masksToBounds = YES;
    }
    return _nameMaskView;
}

- (UITextField *) nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.font = CYPingFangSCMedium(14.f);
        _nameTF.textColor = [UIColor blackColor];
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"起一个能坚持下来的名字吧~"];
        placeholder.font = CYPingFangSCMedium(14.f);
        placeholder.color = RGBColor(195, 196, 192);
        _nameTF.attributedPlaceholder = placeholder;
    }
    return _nameTF;
}

- (UIView *) nameBlank{
    if (!_nameBlank) {
        _nameBlank = [UIView new];
        _nameBlank.backgroundColor = kBackGroungColor;
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
        _timeMaskView.backgroundColor = kContainerColor;
    }
    return _timeMaskView;
}

- (UILabel *) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = CYPingFangSCMedium(16);
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.text = @"起止时间";
    }
    return _timeLabel;
}

- (UILabel *) startTimeLabel{
    if (!_startTimeLabel) {
        _startTimeLabel = [UILabel new];
        _startTimeLabel.font = CYPingFangSCMedium(12);
        _startTimeLabel.textColor = [UIColor blackColor];
        _startTimeLabel.text = @"开始时间";
    }
    return _startTimeLabel;
}

- (UILabel *) endTimeLabel{
    if (!_endTimeLabel) {
        _endTimeLabel = [UILabel new];
        _endTimeLabel.font = CYPingFangSCMedium(12);
        _endTimeLabel.textColor = [UIColor blackColor];
        _endTimeLabel.text = @"结束时间";
    }
    return _endTimeLabel;
}

- (UILabel *) totalDays{
    if (!_totalDays) {
        _totalDays = [UILabel new];
        _totalDays.font = CYPingFangSCMedium(14);
        _totalDays.textColor = [UIColor blackColor];
        [self p_configTotalInfo];
    }
    return _totalDays;
}

- (UIButton *) startTimeBtn{
    @weakify(self);
    if (!_startTimeBtn) {
        _startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _startTimeBtn.titleLabel.font = CYPingFangSCRegular(12.f);
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
        [_endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _endTimeBtn.titleLabel.font = CYPingFangSCRegular(12.f);
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
        _timeBlank.backgroundColor = kBackGroungColor;
    }
    return _timeBlank;
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
        _pingciLabel.font = CYPingFangSCMedium(16.f);
        _pingciLabel.textColor = [UIColor blackColor];
    }
    return _pingciLabel;
}

- (DKPingCiSettingView *) pingciSettingView{
    if (!_pingciSettingView) {
        _pingciSettingView = [DKPingCiSettingView new];
        _pingciSettingView.model = self.model;
    }
    return _pingciSettingView;
}

- (UIView *) pingciBlank{
    if (!_pingciBlank) {
        _pingciBlank = [UIView new];
        _pingciBlank.backgroundColor = [UIColor clearColor];
    }
    return _pingciBlank;
}

- (UISegmentedControl *) segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"固定",@"每周",@"每月"]];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = kContainerColor;
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
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
