//
//  DKVersionHistoryCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/19.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKVersionHistoryCell.h"
#import "DKVersionModel.h"

@interface DKVersionHistoryCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIView  *containerView;
@property (nonatomic, strong) DKVersionModel *model;
@end

@implementation DKVersionHistoryCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self addConstrainss];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) layoutSubviews{
    [super layoutSubviews];
    [self.containerView cy_cornerRound:UIRectCornerTopRight|UIRectCornerBottomRight size:CGSizeMake(15, 15)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupSubviews
{
    self.contentView.backgroundColor = kBackGroungColor;
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.versionLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.desLabel];
}

- (void) addConstrainss
{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(0);
        make.height.offset(30);
        make.width.offset(60);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.mas_equalTo(self.containerView);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView.mas_bottom).offset(10);
        make.left.offset(20);
        make.bottom.offset(-10);
        make.right.offset(-20);
    }];
}

- (void) configModel:(id)model
{
    self.model = model;
    self.versionLabel.text = [NSString stringWithFormat:@"v%@",self.model.version];
    self.timeLabel.text=  self.model.date;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.model.des];
    att.lineSpacing = 20.f;
    att.font = DKFont(14);
    att.color = kTitleColor;
    self.desLabel.attributedText = att;
}

- (UILabel *) versionLabel{
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        _versionLabel.font = DKFont(14);
        _versionLabel.textColor = [UIColor blackColor];
    }
    return _versionLabel;
}

- (UILabel *) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = DKFont(13);
        _timeLabel.textColor = kSubTitleColor;
        _timeLabel.text = @"";
    }
    return _timeLabel;
}

- (UILabel *) desLabel{
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.font = DKFont(14);
        _desLabel.textColor = kTitleColor;
        _desLabel.text = @"";
        _desLabel.numberOfLines = 0;
    }
    return _desLabel;
}

- (UIView *) containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = kMainColor;
    }
    return _containerView;
}
@end
