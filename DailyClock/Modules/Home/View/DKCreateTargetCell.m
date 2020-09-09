//
//  DKCreateTargetCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKCreateTargetCell.h"
#import "DKTargetModel.h"

@interface DKCreateTargetCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DKTargetModel *model;
@end

@implementation DKCreateTargetCell
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
    [self.bgImageView addSubview:self.iconImgView];
    [self.bgImageView addSubview:self.titleLabel];
}

- (void) addConstrainss
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.offset(0);
        make.width.height.offset(36);
//        make.top.offset(20);
//        make.bottom.offset(-20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(30);
        make.centerY.offset(0);
    }];
}

- (void) configModel:(id)model
{
    self.model = model;
    self.titleLabel.text = self.model.title;
    self.bgImageView.image = [UIImage imageNamed:self.model.backgroundImage];
    self.iconImgView.image = [UIImage imageNamed:self.model.icon];
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYPingFangSCMedium(14);
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIImageView *) iconImgView{
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"drink"];
    }
    return _iconImgView;
}

- (UIImageView *) bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@""];
    }
    return _bgImageView;
}
@end
