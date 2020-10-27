//
//  DKDailyClockTimeSettingView.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/10.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDailyClockTimeSettingView.h"
#import "DKDailyClockMusicItemCell.h"
#import "DKPlayMusicModel.h"

#define MAX_COUNT 10000

@interface DKDailyClockTimeSettingView ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *leftPickerView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, copy  ) CYIDBlock block;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) NSMutableArray *pickerDataSource;
@property (nonatomic, strong) NSMutableArray *leftPickerDataSource;
@property (nonatomic, strong) NSMutableArray *tableViewDatasource;

@property (nonatomic, strong) DKReminder *reminder;

@end

@implementation DKDailyClockTimeSettingView

+ (instancetype) showOnView:(UIView *)aView model:(DKTargetModel *)model complete:(CYIDBlock)block{
    DKDailyClockTimeSettingView *settingView = [DKDailyClockTimeSettingView new ];
    settingView.model = model;
    settingView.block = block;
    [aView addSubview:settingView];

    [settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    settingView.container.alpha = 0.f;
    settingView.container.transform = CGAffineTransformMakeScale(0.2, 0.2);
    settingView.backgroundView.alpha = 0.f;

    [UIView animateWithDuration:0.35 animations:^{
        settingView.container.transform = CGAffineTransformIdentity;
        settingView.backgroundView.alpha = 0.6;
        settingView.container.alpha = 1;
    }];
    return settingView;
}


- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
  }
  return self;
}

- (void) setupSubviews
{
    [self addSubview:self.backgroundView];
    [self addSubview:self.container];
    [self.container addSubview:self.segment];
    [self.container addSubview:self.tableView];
    [self.container addSubview:self.iconImageView];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.leftPickerView];
    [self.container addSubview:self.pickerView];
    
    [self.container addSubview:self.cancleBtn];
    [self.container addSubview:self.confirmBtn];
    
    NSDate *current = [NSDate date];
    for (int i = 0; i < self.pickerDataSource.count; i++) {
        if (i == 0) {
            NSInteger hour = MAX_COUNT/2 - 8 + current.hour;
            [self.pickerView selectRow:hour inComponent:i animated:NO];
        }
        else{
            NSInteger minute = MAX_COUNT/2 - 20 + current.minute;
            [self.pickerView selectRow:minute inComponent:i animated:NO];
        }
    }
    @weakify(self);
    [RACObserve(self.segment, selectedSegmentIndex) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger idx = [x intValue];
        if (idx == 0) {
            self.tableView.hidden =YES;
            self.pickerView.hidden = NO;
            self.leftPickerView.hidden = NO;
        }
        else{
            self.tableView.hidden = NO;
            self.pickerView.hidden = YES;
            self.leftPickerView.hidden = YES;
        }
    }];
}

- (void) addConstrainss
{
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(15);
        make.width.height.offset(40);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    [self.leftPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.offset(0);
        make.width.offset((kScreenWidth-80)/2.f);
        make.height.offset(300);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.leftPickerView.mas_right);
        make.width.offset((kScreenWidth-80)/2.f);
        make.height.offset(300);
        make.right.offset(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.width.offset((kScreenWidth-80));
        make.height.offset(300);
        make.left.right.offset(0);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(self.pickerView.mas_bottom).offset(0);
        make.height.offset(60);
        make.width.mas_equalTo(self.container).multipliedBy(0.5);
        make.bottom.offset(0);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.mas_equalTo(self.pickerView.mas_bottom).offset(0);
        make.height.offset(60);
        make.width.mas_equalTo(self.container).multipliedBy(0.5);
        make.bottom.offset(0);
    }];
}

- (void) setModel:(DKTargetModel *)model{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:_model.icon];
    self.titleLabel.text = _model.title;
}

#pragma mark - tableViewDelegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKPlayMusicModel *musicName = [self.tableViewDatasource objectAtIndex:indexPath.row];
    static NSString *identifier = @"DKDailyClockMusicItemCell";
    DKDailyClockMusicItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell configModel:musicName];
    cell.reminder = self.reminder;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDatasource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DKPlayMusicModel *musicName = [self.tableViewDatasource objectAtIndex:indexPath.row];
    DKDailyClockMusicItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell stop];
    // 置空
    for (DKPlayMusicModel *model in self.tableViewDatasource) {
        model.isPlaying = NO;
    }
    
    [tableView reloadData];
    
    self.reminder.alert = musicName.alert;
    musicName.isPlaying = YES;
    cell.reminder = self.reminder;
    
    [cell start];
}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    DKDailyClockMusicItemCell *musicCell = (DKDailyClockMusicItemCell *) cell;
    [musicCell stop];
}


#pragma mark - lazy


- (DKReminder *) reminder{
    if (!_reminder) {
        _reminder = [DKReminder new];
        _reminder.targetModel = self.model;
    }
    return _reminder;
}

- (UIView *) backgroundView{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    }
    return _backgroundView;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = DKIOS13ContainerColor();
        _container.layer.cornerRadius = 12.f;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UIImageView *) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = DKBoldFont(16);
        _titleLabel.textColor = DKIOS13LabelColor();
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UIPickerView *) leftPickerView{
    if (!_leftPickerView) {
        _leftPickerView = [UIPickerView new];
        _leftPickerView.delegate = self;
        _leftPickerView.dataSource = self;
    }
    return _leftPickerView;
}


- (UISegmentedControl *) segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"时间点",@"提示音"]];
        _segment.selectedSegmentIndex = 0;
        _segment.tintColor = kContainerColor;
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        [_segment setTitleTextAttributes:@{NSFontAttributeName:DKFont(14)} forState:UIControlStateNormal];
    }
    return _segment;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor  =[UIColor clearColor];
        [_tableView registerClass:[DKDailyClockMusicItemCell class] forCellReuseIdentifier:@"DKDailyClockMusicItemCell"];
    }
    return _tableView;
}

- (UIPickerView *) pickerView{
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.leftPickerView) {
        return 1;
    }
    else{
        return 2;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.leftPickerView) {
        return self.leftPickerDataSource.count;
    }
    return MAX_COUNT;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.leftPickerView) {
        return [self.leftPickerDataSource objectAtIndex:row];
    }
    else{
        NSArray *arr = self.pickerDataSource[component];
        NSString *title = [arr objectAtIndex:row%arr.count];
        return  title;
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lbl = (UILabel *)view;

    if (lbl == nil) {
        lbl = [[UILabel alloc]init];

        //在这里设置字体相关属性

        lbl.font = DKFont(15);

        lbl.textColor = DKIOS13LabelColor();

        lbl.textAlignment = NSTextAlignmentCenter;

        [lbl setBackgroundColor:[UIColor clearColor]];

    }

        //重新加载lbl的文字内容

        lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];

        return lbl;

}



- (UIButton *) cancleBtn{
    @weakify(self);
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = DKFont(15);
        [_cancleBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        _cancleBtn.backgroundColor = DKIOS13ContainerColor();
        [[_cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            vibrate();
            [self hide];
        }];
    }
    return _cancleBtn;
}

- (UIButton *) confirmBtn{
    @weakify(self);
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = DKFont(15);
        [_confirmBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = DKIOS13ContainerColor();
        [[_confirmBtn  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            vibrate();
            @strongify(self);
            if (self.block) {
                NSMutableDictionary *info = @{}.mutableCopy;
                NSString *leftTitle = [self.leftPickerDataSource objectAtIndex:[self.leftPickerView selectedRowInComponent:0]];
                NSArray *hourArr = [self.pickerDataSource objectAtIndex:0];
                NSArray *minuteArr = [self.pickerDataSource objectAtIndex:1];
                NSString *hour = [hourArr objectAtIndex:([self.pickerView selectedRowInComponent:0]%24)];
                NSString *minute = [minuteArr objectAtIndex:([self.pickerView selectedRowInComponent:1]%60)];
                
                info[@"title"] = leftTitle;
                info[@"hour"] = hour;
                info[@"minute"] = minute;
                
                self.reminder.clockDate = [NSDate dateWithString:[NSString stringWithFormat:@"%@:%@",hour,minute] format:@"HH:mm"];
                self.reminder.dayOfWeeks = leftTitle;
                
                self.block(self.reminder);
            }
            [self hide];
        }];
    }
    return _confirmBtn;
}

- (void) hide {
    [UIView animateWithDuration:0.35 animations:^{
        self.container.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.container.alpha = 0.f;
        self.backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSMutableArray *) pickerDataSource{
    if (!_pickerDataSource) {
        _pickerDataSource = [NSMutableArray array];
        NSMutableArray *hour = @[].mutableCopy;
        NSMutableArray *minute = @[].mutableCopy;
        for (int i = 0; i < 24; i++) {
            [hour addObject:[NSString stringWithFormat:@"%02d",i]];
        }
        
        for (int i = 0; i < 60; i++) {
            [minute addObject:[NSString stringWithFormat:@"%02d",i]];
        }
        
        [_pickerDataSource addObject:hour];
        [_pickerDataSource addObject:minute];
    }
    return _pickerDataSource;
}

- (NSMutableArray *) leftPickerDataSource{
    if (!_leftPickerDataSource) {
        _leftPickerDataSource = [NSMutableArray array];
        [_leftPickerDataSource addObject:@"每一天"];
        [_leftPickerDataSource addObject:@"工作日"];
        [_leftPickerDataSource addObject:@"周末"];
        [_leftPickerDataSource addObject:@"周一"];
        [_leftPickerDataSource addObject:@"周二"];
        [_leftPickerDataSource addObject:@"周三"];
        [_leftPickerDataSource addObject:@"周四"];
        [_leftPickerDataSource addObject:@"周五"];
        [_leftPickerDataSource addObject:@"周六"];
        [_leftPickerDataSource addObject:@"周日"];
    }
    return _leftPickerDataSource;
}

- (NSMutableArray *) tableViewDatasource{
    if (!_tableViewDatasource) {
        _tableViewDatasource = @[].mutableCopy;
        
        [_tableViewDatasource addObject:@"Arpeggio Interlude Guitar"];
        [_tableViewDatasource addObject:@"Be Together"];
        [_tableViewDatasource addObject:@"Breathless"];
        [_tableViewDatasource addObject:@"Brooklyn Nights Guitar"];
        [_tableViewDatasource addObject:@"Deep Electric Piano"];
        [_tableViewDatasource addObject:@"Empire State Harp"];
        [_tableViewDatasource addObject:@"Funk Era Piano"];
        [_tableViewDatasource addObject:@"In Valley"];
        [_tableViewDatasource addObject:@"Inferno Disco Electric Piano"];

        [_tableViewDatasource addObject:@"Longing Piano"];
        [_tableViewDatasource addObject:@"Moving On Bell"];
        [_tableViewDatasource addObject:@"Shining Star Electric Piano"];
        [_tableViewDatasource addObject:@"Sugar Sweet Guitar"];
        [_tableViewDatasource addObject:@"Twilight"];
        [_tableViewDatasource addObject:@"Across the Liffey Lead Guitar"];
        
        NSMutableArray *tem = @[].mutableCopy;
        for (NSString *music in _tableViewDatasource) {
            DKPlayMusicModel *musicModel = [DKPlayMusicModel new ];
            musicModel.alert = music;
            [tem addObject:musicModel];
        }
        
        [_tableViewDatasource removeAllObjects];
        [_tableViewDatasource addObjectsFromArray:tem];
        
        
    }
    return _tableViewDatasource;
}
@end
