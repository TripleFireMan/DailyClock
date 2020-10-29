//
//  DKTargetCollectionViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/28.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetCollectionViewCell.h"

@implementation DKTargetCollectionViewCell
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor cy_randomColor];
        [self.contentView addSubview:self.iconContainer];
        [self.iconContainer addSubview:self.iconImageView];
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.continueLabel];
        
        [self.iconContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.width.height.offset(66);
            make.centerX.offset(0);
        }];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.height.offset(36);
            make.centerX.offset(0);
        }];
        
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconContainer.mas_bottom).offset(5);
            make.centerX.offset(0);
        }];
        
        [self.continueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.textLabel.mas_bottom).offset(4);
            make.centerX.offset(0);
            make.bottom.offset(-10);
        }];
    }
    return self;
}

- (void) setModel:(DKTargetModel *)model{
    _model = model;
    
    self.textLabel.text=  _model.title;
    self.textLabel.font = DKBoldFont(12);
    self.continueLabel.font = DKFont(11);
    if (_model.continueCont!=0) {
        self.continueLabel.text = [NSString stringWithFormat:@"已打卡%@天",@(_model.signModels.count)];
    }else{
        self.continueLabel.text = nil;
    }
    
    if ([self isTodaySigned]) {
        self.iconContainer.backgroundColor = [UIColor colorWithHexString:model.color];
        self.iconImageView.image = [UIImage imageNamed:_model.icon];
    }
    else{
        self.iconContainer.backgroundColor = DKIOS13ContainerColor();
        self.iconImageView.image = [UIImage imageNamed:[_model.icon stringByAppendingString:@"-3"]];
    }
}

- (UIView *) iconContainer{
    @weakify(self);
    if (!_iconContainer) {
        _iconContainer = [UIView new];
        _iconContainer.backgroundColor = [UIColor whiteColor];
        _iconContainer.layer.cornerRadius = 33.f;
        _iconContainer.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        _iconContainer.layer.borderWidth = 1.f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (![self isTodaySigned]) {
                DKSignModel *signModel = [DKSignModel new];
                NSDate *day = [[NSDate date] dateByAddingDays:0];
                signModel.date = day;
                [self.model.signModels addObject:signModel];
                [[DKTargetManager cy_shareInstance] cy_save];
                [self animate];
                self.clickBlock ? self.clickBlock(signModel) : nil;
            }
            else{
                [XHToast showBottomWithText:@"今日已打卡，明天再来吧！"];
            }
        }];
        _iconContainer.userInteractionEnabled = YES;
        [_iconContainer addGestureRecognizer:tap];
    }
    return _iconContainer;
}

- (BOOL) isTodaySigned {
    __block BOOL hasSigned = NO;
    [[self.model signModels] enumerateObjectsUsingBlock:^(DKSignModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.date isToday]) {
            hasSigned = YES;
        }
    }];
    return hasSigned;
}

- (UIImageView *) iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@""];
    }
    return _iconImageView;
}

- (UILabel *) textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = DKBoldFont(12);
        _textLabel.textColor = DKIOS13LabelColor();
        _textLabel.text = @"";
    }
    return _textLabel;
}

- (UILabel *) continueLabel{
    if (!_continueLabel) {
        _continueLabel = [UILabel new];
        _continueLabel.font = DKFont(11);
        _continueLabel.textColor = DKIOS13SecondLabelColor();
    }
    return _continueLabel;
}

- (void) animate{
    [UIView transitionWithView:self.iconContainer duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        if ([self isTodaySigned]) {
            self.iconContainer.backgroundColor = [UIColor colorWithHexString:self.model.color];
            self.iconImageView.image = [UIImage imageNamed:self.model.icon];
        }
        else{
            self.iconContainer.backgroundColor = DKIOS13BackgroundColor();
        }
        [self setModel:self.model];
       
    } completion:^(BOOL finished) {
        
    }];
}
@end
