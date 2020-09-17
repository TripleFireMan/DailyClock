//
//  DKCustomeTargetCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKCustomeTargetCell.h"
#import "DKTargetModel.h"

@interface DKCustomeTargetCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DKTargetModel *model;

@end

@implementation DKCustomeTargetCell

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
        make.centerY.offset(0);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-20);
        make.width.height.offset(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.offset(5);
    }];
}

- (void) configModel:(id)model
{
    self.model = model;
    self.titleLabel.text = self.model.title;
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:[DKApplication cy_shareInstance].fontName size:16];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIImageView *) iconImgView{
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"tianjia"];
    }
    return _iconImgView;
}

- (UIImageView *) bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.layer.cornerRadius = 6.f;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.backgroundColor = kThemeLineColor;
    }
    return _bgImageView;
}
@end
