//
//  DKHomeItemTableViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/7.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKHomeItemTableViewCell.h"
#import "DKWeekCollectionViewCell.h"

@interface DKHomeItemTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView       *bgImageView;
@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIImageView       *iconImageView;

@property (nonatomic, strong) UILabel           *countLabel;
@property (nonatomic, strong) UILabel           *continueLabel;
@property (nonatomic, strong) UILabel           *totalCountLabel;
@property (nonatomic, strong) UICollectionView  *collectionView;
@end

@implementation DKHomeItemTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
        [self addConstrainss];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupSubviews
{
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.iconImageView];
    [self.bgImageView addSubview:self.nameLabel];
    [self.bgImageView addSubview:self.countLabel];
    [self.bgImageView addSubview:self.continueLabel];
    [self.bgImageView addSubview:self.totalCountLabel];
    [self.contentView addSubview:self.collectionView];
}

- (void) addConstrainss
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(5);
        make.bottom.offset(-5);
//        make.height.offset(120);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.offset(30);
        make.width.height.offset(36);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.centerY.mas_equalTo(self.iconImageView);
//        make.top.offset(20);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-30);
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    
    [self.continueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.countLabel);
    }];
    
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.continueLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.continueLabel.mas_right);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(50);
        make.top.mas_equalTo(self.totalCountLabel.mas_bottom).offset(10);
        make.bottom.offset(-20);
    }];
}

- (void) setModel:(DKTargetModel *)model{
    _model = model;
    self.bgImageView.image = [[UIImage imageNamed:_model.backgroundImage] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    self.iconImageView.image = [UIImage imageNamed:_model.icon];
    self.nameLabel.text = _model.title;
    
}

- (UIImageView *) bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgImageView;
}

- (UIImageView *) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *) nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = CYPingFangSCMedium(16);
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

- (UILabel *) countLabel{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = CYPingFangSCMedium(12);
        _countLabel.textColor = kTitleColor;
        _countLabel.text = @"";
    }
    return _countLabel;
}

- (UILabel *) continueLabel{
    if (!_continueLabel) {
        _continueLabel = [UILabel new];
        _continueLabel.font = CYPingFangSCMedium(12);
        _continueLabel.textColor = kTitleColor;
        _continueLabel.text = @"";
    }
    return _continueLabel;
}

- (UILabel *) totalCountLabel{
    if (!_totalCountLabel) {
        _totalCountLabel = [UILabel new];
        _totalCountLabel.font = CYPingFangSCMedium(12);
        _totalCountLabel.textColor = kSubTitleColor;
        _totalCountLabel.text = @"";
    }
    return _totalCountLabel;
}

- (UICollectionView *) collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(50, 50);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 10.f;
        flow.headerReferenceSize = CGSizeMake(15, 50);
        flow.footerReferenceSize = CGSizeMake(15, 50);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[DKWeekCollectionViewCell class] forCellWithReuseIdentifier:@"DKWeekCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView cy_adjustForIOS13];
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
@end
