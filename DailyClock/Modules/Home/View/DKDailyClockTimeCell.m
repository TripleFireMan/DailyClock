//
//  DKDailyClockTimeCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDailyClockTimeCell.h"
@interface DKDailyClockTimeCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *topimageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *deleteImageView;
@property (nonatomic, strong) UIImageView *addImageView;

@end
@implementation DKDailyClockTimeCell
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.contentView.clipsToBounds  =NO;
        [self.contentView addSubview:self.container];
        [self.container addSubview:self.addImageView];
        [self.container addSubview:self.topimageView];
        [self.container addSubview:self.deleteImageView];
        [self.container addSubview:self.timeLabel];
        
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
        
        [self.topimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(10);
            make.width.height.offset(28);
        }];
        
        [self.deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(6);
            make.top.offset(-6);
            make.width.height.offset(20);
        }];
        
        [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.height.offset(15);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topimageView.mas_bottom).offset(10);
            make.centerX.offset(0);
            make.bottom.offset(-10);
        }];
    }
    return self;
}

- (void) setModel:(DKReminder *)model{
    _model = model;
    self.addImageView.hidden = YES;
    self.topimageView.hidden = YES;
    self.timeLabel.hidden = YES;
    self.deleteImageView.hidden = YES;
    if (_model.isAdd) {
        self.addImageView.hidden = NO;
        
    }
    else{
        self.timeLabel.hidden = NO;
        self.topimageView.hidden = NO;
        self.timeLabel.text = [_model.clockDate stringWithFormat:@"HH:mm"];
        self.deleteImageView.hidden = NO;
    }
    
}

- (UIImageView *) topimageView{
    if (!_topimageView) {
        _topimageView = [UIImageView new];
        _topimageView.image = [UIImage imageNamed:@"shijian"];
    }
    return _topimageView;
}


- (UILabel *) timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = DKFont(13);
        _timeLabel.textColor = DKIOS13LabelColor();
    }
    return _timeLabel;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = DKIOS13BackgroundColor();
        _container.layer.cornerRadius = 12.f;
//        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UIImageView *) deleteImageView{
    if (!_deleteImageView) {
        _deleteImageView = [UIImageView new];
        _deleteImageView.image = [UIImage imageNamed:@"delete-mini2"];
    }
    return _deleteImageView;
}

- (UIImageView *) addImageView{
    if (!_addImageView) {
        _addImageView = [UIImageView new];
        _addImageView.image = [UIImage imageNamed:@"NewTarget_Time_Add"];
    }
    return _addImageView;
}
@end
