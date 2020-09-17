//
//  DKWeekCollectionViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKWeekCollectionViewCell.h"

@interface DKWeekCollectionViewCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *textLabel;

@end
@implementation DKWeekCollectionViewCell

- (void) setWeekModel:(DKTargetPinCiWeekModel *)weekModel{
    _weekModel = weekModel;
    self.textLabel.text = _weekModel.weekName;
    if (!_weekModel.isSelected) {
        self.container.backgroundColor = kContainerColor;
        self.container.layer.borderColor = [UIColor clearColor].CGColor;
    }
    else{
        self.container.backgroundColor = kMainColor;
        self.container.layer.borderColor = [UIColor blackColor].CGColor;
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    self.container.layer.cornerRadius = 18.f;
    self.container.layer.masksToBounds = YES;
}
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.container];
        [self.container addSubview:self.textLabel];
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return self;
}


- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = kMainColor;
        _container.layer.borderWidth = 1;
        _container.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _container;
}

- (UILabel *) textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = DKFont(12);
        _textLabel.textColor = [UIColor blackColor];
    }
    return _textLabel;
}

@end
