//
//  DKCurrentTableViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/29.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKCurrentTableViewCell.h"
@interface DKCurrentTableViewCell ()

@property (nonatomic, strong) UILabel *days;
@property (nonatomic, strong) UILabel *contineLabel;

@end

@implementation DKCurrentTableViewCell

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
    [super setupSubviews];
    [self.contentView addSubview:self.days];
    [self.contentView addSubview:self.contineLabel];
}

- (void) addConstrainss
{
    [super addConstrainss];
    [self.days mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-10);
        make.right.offset(-25);
    }];
    
    [self.contineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.days.mas_bottom).offset(10);
        make.right.offset(-25);
    }];
}

- (void) configModel:(id)model
{
    [super configModel:model];
    
    NSString *daysString = [NSString stringWithFormat:@"%ld 天",self.model.signModels.count];
    NSMutableAttributedString *daysAtt = [[NSMutableAttributedString alloc] initWithString:daysString];
    daysAtt.color = kTitleColor;
    daysAtt.font = DKBoldFont(18);
    [daysAtt setFont:CYBebas(20) range:NSMakeRange(0, daysString.rangeOfAll.length-1)];
    self.days.attributedText = daysAtt;
    self.contineLabel.font = DKFont(15);
    
}

- (UILabel *) days{
    if (!_days) {
        _days = [UILabel new];
        _days.textColor = [UIColor blackColor];
        _days.text = @"";
        _days.textAlignment = NSTextAlignmentRight;
    }
    return _days;
}

- (UILabel *) contineLabel{
    if (!_contineLabel) {
        _contineLabel = [UILabel new];
        _contineLabel.font = DKFont(15);
        _contineLabel.textColor = kSubTitleColor;
        _contineLabel.text = @"已坚持";
        _contineLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contineLabel;
}
@end
