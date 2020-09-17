//
//  DKDetailAnalyticsView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/17.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDetailAnalyticsView.h"

@implementation DKDetailAnalyticsView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kContainerColor;
        [self setUpSubviews];
        [self addConstraintss];
    }
    return self;
}

- (void) setUpSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
}

- (void) addConstraintss {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.centerX.offset(0);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = DKBoldFont(13);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UILabel *) subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel new];
        _subtitleLabel.font = DKFont(13);
        _subtitleLabel.textColor = RGBColor(68, 68, 68);
        _subtitleLabel.text = @"";
    }
    return _subtitleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
