//
//  DKPingCiSettingView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKPingCiSettingView.h"
#import "DKWeekCollectionViewCell.h"
#import "DKPingCiSettingWeekMonthView.h"
@interface DKPingCiSettingView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DKPingCiSettingWeekMonthView *weekView;
@property (nonatomic, strong) DKPingCiSettingWeekMonthView *monthView;
@end

@implementation DKPingCiSettingView

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
    [self addSubview:self.collectionView];
    [self addSubview:self.weekView];
    [self addSubview:self.monthView];
}

- (void) addConstrainss
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(50);
        make.centerY.offset(0);
    }];
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.offset(50);
        make.centerY.offset(0);
    }];
    
    [self.monthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.offset(50);
        make.centerY.offset(0);
    }];
}

- (void) setModel:(DKTargetModel *)model{
    @weakify(self);
    _model = model;
    
    [self.collectionView reloadData];
    self.weekView.model = _model;
    self.monthView.model = _model;
    
    [RACObserve(_model, pinciType) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSInteger type = [x integerValue];
        self.collectionView.hidden = YES;
        self.monthView.hidden = YES;
        self.weekView.hidden = YES;
        switch (type) {
            case DKTargetPinCiType_Guding:
                self.collectionView.hidden = NO;
                break;
            case DKTargetPinCiType_Week:
                self.weekView.hidden = NO;
                break;
            case DKTargetPinCiType_Month:
                self.monthView.hidden = NO;
                break;
            default:
                break;
        }
    }];
}

- (UICollectionView *) collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(36, 36);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 10.f;
        flow.headerReferenceSize = CGSizeMake(15, 36);
        flow.footerReferenceSize = CGSizeMake(15, 36);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[DKWeekCollectionViewCell class] forCellWithReuseIdentifier:@"DKWeekCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView cy_adjustForIOS13];
    }
    return _collectionView;
}

- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DKTargetPinCiWeekModel *weekModel = [self.model.weekSettings objectAtIndex:indexPath.row];
    DKWeekCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DKWeekCollectionViewCell" forIndexPath:indexPath];
    cell.weekModel = weekModel;
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.weekSettings.count;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DKTargetPinCiWeekModel *weekModel = [self.model.weekSettings objectAtIndex:indexPath.row];
    weekModel.isSelected = !weekModel.isSelected;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (DKPingCiSettingWeekMonthView *) weekView{
    if (!_weekView) {
        _weekView = [[DKPingCiSettingWeekMonthView alloc] initWithFrame:CGRectZero pingciType:DKTargetPinCiType_Week];
    }
    return _weekView;
}

- (DKPingCiSettingWeekMonthView *) monthView{
    if (!_monthView) {
        _monthView = [[DKPingCiSettingWeekMonthView alloc] initWithFrame:CGRectZero pingciType:DKTargetPinCiType_Month];
    }
    return _monthView;
}
@end
