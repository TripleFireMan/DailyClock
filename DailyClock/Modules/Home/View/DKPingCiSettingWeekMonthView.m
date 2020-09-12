//
//  DKPingCiSettingWeekMonthView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKPingCiSettingWeekMonthView.h"

@interface DKPingCiSettingWeekMonthView ()

@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITextField *inputTf;
@property (nonatomic, strong) UILabel *perLabel;
@property (nonatomic, assign) DKTargetPinCiType type;
@end

@implementation DKPingCiSettingWeekMonthView

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
  }
  return self;
}

- (id) initWithFrame:(CGRect)frame pingciType:(DKTargetPinCiType)type{
    self = [super initWithFrame:frame];
    if (self) {
        @weakify(self);
        _type = type;
        [self setupSubviews];
        [self addConstrainss];
        
        [self.inputTf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            NSInteger value = [x integerValue];
            if (self.model.pinciType == self.type) {
                if (self.type == DKTargetPinCiType_Month) {
                    self.model.monthOfDay = value;
                }
                else if (self.type == DKTargetPinCiType_Week){
                    self.model.weekofDay = value;
                }
            }
            
        }];
    }
    return self;
}

- (void) setupSubviews
{
    [self addSubview:self.namelabel];
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.inputTf];
    [self addSubview:self.perLabel];
}

- (void) addConstrainss
{
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.namelabel.mas_right).offset(15);
        make.height.offset(40);
        make.width.offset(40);
        make.centerY.offset(0);
    }];
    
    [self.inputTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
    [self.perLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(self.maskView.mas_right).offset(15);
        make.right.offset(-15);
    }];
}

- (void)setModel:(DKTargetModel *)model{
    _model = model;
    

}

- (UILabel *) namelabel{
    if (!_namelabel) {
        _namelabel = [UILabel new];
        _namelabel.font = CYPingFangSCMedium(12);
        _namelabel.textColor = [UIColor blackColor];
        if (self.type == DKTargetPinCiType_Month) {
            _namelabel.text = @"每月";
        }
        else if (self.type == DKTargetPinCiType_Week){
            _namelabel.text = @"每周";
        }
    }
    return _namelabel;
}

- (UILabel *) perLabel{
    if (!_perLabel) {
        _perLabel = [UILabel new];
        _perLabel.text = @"次";
        _perLabel.font = CYPingFangSCMedium(12);
        _perLabel.textColor = [UIColor blackColor];
    }
    return _perLabel;
}

- (UIView *) maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.layer.cornerRadius = 3.f;
        _maskView.layer.masksToBounds = YES;
        _maskView.backgroundColor = kContainerColor;
    }
    return _maskView;
}

- (UITextField *) inputTf{
    if (!_inputTf) {
        _inputTf = [[UITextField alloc] init];
        _inputTf.placeholder =@"0";
        _inputTf.font = CYPingFangSCMedium(14.f);
        _inputTf.textColor = kDetailColor;
        _inputTf.textAlignment = NSTextAlignmentCenter;
        _inputTf.keyboardType  = UIKeyboardTypeNumberPad;
    }
    return _inputTf;
}
@end
