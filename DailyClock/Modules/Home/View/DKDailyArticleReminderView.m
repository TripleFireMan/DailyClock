//
//  DKDailyArticleReminderView.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDailyArticleReminderView.h"
#import "DKDailyClockTimeCell.h"

@interface DKDailyArticleReminderView () <
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIView            *blankView;
@property (nonatomic, strong) DKTargetModel     *model;
@end

@implementation DKDailyArticleReminderView

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
      [self bindData];
  }
  return self;
}

- (void) setupSubviews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.blankView];
}

- (void) addConstrainss
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.height.offset(150);
    }];
    
    [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(15);
        make.left.right.offset(0);
        make.height.offset(10);
        make.bottom.offset(0);
    }];
}

- (void) bindData {
    @weakify(self);
    [RACObserve(self.collectionView, contentSize) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        CGSize size = [x CGSizeValue];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(size.height);
        }];
    }];
}

- (void) configModel:(id)model
{
    self.model = model;
    [self.collectionView reloadData];
}

- (void) reload {
    [self.collectionView reloadData];
}

#pragma mark - CollectionViewDelegate

- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DKReminder *reminder = [self.model.reminders objectAtIndex:indexPath.row];
    DKDailyClockTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DKDailyClockTimeCell" forIndexPath:indexPath];
    cell.model = reminder;
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.reminders.count;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    vibrate();
    DKReminder *reminder = [self.model.reminders objectAtIndex:indexPath.row];
    if (self.block) {
        self.block(reminder);
    }
//    if (reminder.isAdd) {
//        DKReminder *reminder1 = [DKReminder new];
//        reminder1.clockDate = [NSDate date];
//        [self.model.reminders addObject:reminder1];
//        [self.collectionView reloadData];
//    }
//    else{
//        [self.model.reminders removeLastObject];
//        [self.collectionView reloadData];
//    }
}

#pragma mark - Lazy

- (UICollectionView *) collectionView{
    if (!_collectionView) {
        NSInteger itemCount = 5;
        CGFloat itemWidth = (kScreenWidth - 30 - (itemCount - 1) * 10.f) / itemCount;
        CGFloat itemHeight = 71.f;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.clipsToBounds = NO;
        [_collectionView registerClass:[DKDailyClockTimeCell class] forCellWithReuseIdentifier:@"DKDailyClockTimeCell"];
    }
    return _collectionView;
}

- (UIView *) blankView{
    if (!_blankView) {
        _blankView = [UIView new];
        _blankView.backgroundColor = DKIOS13ContainerColor();
    }
    return _blankView;
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = DKFont(16);
        _titleLabel.textColor = DKIOS13LabelColor();
        _titleLabel.text = @"设置提醒时间";
    }
    return _titleLabel;
}

@end
