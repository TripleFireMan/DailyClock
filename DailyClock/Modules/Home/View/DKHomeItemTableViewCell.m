//
//  DKHomeItemTableViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/7.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKHomeItemTableViewCell.h"
#import "DKWeekCollectionViewCell.h"
#import "DKHomeItemClockCollectionViewCell.h"

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
        make.left.offset(20);
        make.top.offset(20);
        make.width.height.offset(36);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20);
        make.centerY.mas_equalTo(self.iconImageView);
//        make.top.offset(20);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(15);
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
        make.left.offset(15);
        make.right.offset(-15);
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
    NSString *countText = [NSString stringWithFormat:@"%@ 次",@(_model.signModels.count)];
    NSMutableAttributedString *attCountText = [[NSMutableAttributedString alloc] initWithString:countText];
    attCountText.font = CYBebas(20);
    [attCountText setFont:DKFont(20) range:NSMakeRange(countText.length-1, 1)];
    self.countLabel.attributedText = attCountText;

    NSString *continueContText = [NSString stringWithFormat:@"连续 %@ 次",@([_model continueCont])];
    NSMutableAttributedString *attcontinueContText = [[NSMutableAttributedString alloc] initWithString:continueContText];
    
    attcontinueContText.font = DKFont(13);
    [attcontinueContText setFont:CYBebas(13) range:[continueContText rangeOfString:[NSString stringWithFormat:@"%@",@([_model continueCont])]]];
    
    self.continueLabel.attributedText = attcontinueContText;
    
    NSInteger targetCount= [_model targetCount]-_model.signModels.count;
    if (targetCount <= 0) {
        targetCount = 0;
    }
    NSString *targetCountText = [NSString stringWithFormat:@"目标 %ld 次",targetCount];
    NSMutableAttributedString *atttargetCountText = [[NSMutableAttributedString alloc] initWithString:targetCountText];
    atttargetCountText.font = DKFont(13);
    [atttargetCountText setFont:CYBebas(13) range:[targetCountText rangeOfString:[NSString stringWithFormat:@"%ld",targetCount]]];
    
    self.totalCountLabel.attributedText = atttargetCountText;
    [self.collectionView reloadData];
}

- (UIImageView *) bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
////        _bgImageView.layer.shadowColor = kBorderColor.CGColor;
////        _bgImageView.layer.shadowOpacity  = 1;
//        _bgImageView.backgroundColor = RGBColor(87, 217, 214);
//        _bgImageView.layer.cornerRadius = 12.f;
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
        _nameLabel.font = DKFont(16);
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

- (UILabel *) countLabel{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = CYBebas(20);
        _countLabel.textColor = kTitleColor;
        _countLabel.text = @"";
    }
    return _countLabel;
}

- (UILabel *) continueLabel{
    if (!_continueLabel) {
        _continueLabel = [UILabel new];
        _continueLabel.font = DKFont(12);
        _continueLabel.textColor = kTitleColor;
        _continueLabel.text = @"";
    }
    return _continueLabel;
}

- (UILabel *) totalCountLabel{
    if (!_totalCountLabel) {
        _totalCountLabel = [UILabel new];
        _totalCountLabel.font = DKFont(12);
        _totalCountLabel.textColor = kTitleColor;
        _totalCountLabel.text = @"";
    }
    return _totalCountLabel;
}

- (UICollectionView *) collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = [[self class] itemSize];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumInteritemSpacing = 10.f;
        flow.headerReferenceSize = CGSizeMake(15, [[self class] itemSize].width);
        flow.footerReferenceSize = CGSizeMake(15, [[self class] itemSize].width);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[DKHomeItemClockCollectionViewCell class] forCellWithReuseIdentifier:@"DKHomeItemClockCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView cy_adjustForIOS13];
    }
    return _collectionView;
}

- (__kindof UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DKTargetPinCiWeekModel *weekModel = [self.model.weekSettings objectAtIndex:indexPath.row];
    DKHomeItemClockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DKHomeItemClockCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.model;
    cell.weekModel = weekModel;
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.weekSettings.count;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DKTargetPinCiWeekModel *weekModel = [self.model.weekSettings objectAtIndex:indexPath.row];
    if ([weekModel isToday]) {
        if (![self.model isSignByDate:[NSDate date]]) {
            DKSignModel *signModel = [DKSignModel new];
            NSDate *day = [[NSDate date] dateByAddingDays:0];
            signModel.date = day;
            [self.model.signModels addObject:signModel];
            [[DKTargetManager cy_shareInstance] cy_save];
            self.model = self.model;
            [collectionView reloadData];
            self.clickBlock ? self.clickBlock(signModel) : nil;
        }
        else{
            [XHToast showBottomWithText:@"亲，您今天已经打过卡了哦~"];
        }

    }
}

+ (CGSize) itemSize{
    float width = (kScreenSize.width - 30 - 30 - 6 * 10) / 7.f;
    return CGSizeMake(width, width);
}
@end
