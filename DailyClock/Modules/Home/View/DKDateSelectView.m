//
//  DKDateSelectView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/7.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDateSelectView.h"

@interface DKDateSelectView ()
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *container;;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation DKDateSelectView
+ (instancetype) showOnView:(UIView *)view animated:(BOOL)animated{
    DKDateSelectView *dateView = [DKDateSelectView new];
    [view addSubview:dateView];
    
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    dateView.maskView.alpha  = 0.f;
    
    [dateView layoutIfNeeded];
    
    [UIView animateWithDuration:0.36 animations:^{
        [dateView.container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(dateView.mas_bottom);
            make.left.right.offset(0);
            make.height.offset(300);
        }];
        dateView.maskView.alpha  =1.f;
        [dateView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
    return dateView;
}
- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
  }
  return self;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    [_container cy_cornerRound:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(6, 6)];
}

- (void) setupSubviews
{
    [self addSubview:self.maskView];
    [self addSubview:self.container];
    [self.container addSubview:self.datePicker];
    [self.container addSubview:self.cancelBtn];
    [self.container addSubview:self.confirmBtn];
    [self.container addSubview:self.line];
}

- (void) addConstrainss
{
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom);
        make.left.right.offset(0);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(30);
        make.width.height.offset(44);
        make.bottom.mas_equalTo(self.line.mas_top).offset(-0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.mas_equalTo(self.datePicker.mas_top);
        make.height.offset(CY_Sigle_Line_Height);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(-30);
        make.width.height.offset(44);
        make.bottom.mas_equalTo(self.line.mas_top).offset(-0);
    }];
}

- (void) configModel:(id)model
{

}

- (void) setDate:(NSDate *)date{
    _date = date;
    self.datePicker.date = _date;
}

- (void) hide {
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.36 animations:^{
        [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_bottom);
            make.left.right.offset(0);
        }];
        self.maskView.alpha  = 0.f;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Lazy

- (UIView *) maskView{
    @weakify(self);
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.userInteractionEnabled = YES;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            [self hide];
        }];
        tap.numberOfTapsRequired = 1;
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *) container{
    if (!_container){
        _container = [UIView new];
        _container.backgroundColor = [UIColor whiteColor];
        
    }
    return _container;
}

- (UIButton *) cancelBtn{
    @weakify(self);
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = CYPingFangSCMedium(14.f);
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self hide];
        }];
    }
    return _cancelBtn;
}

- (UIButton *) confirmBtn{
    @weakify(self);
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = CYPingFangSCMedium(14.f);
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.confirmBlock ? self.confirmBlock(self.datePicker.date):nil;
            [self hide];
        }];
    }
    return _confirmBtn;
}

- (UIView *) line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kLineColor;
    }
    return _line;
}

- (UIDatePicker *) datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minimumDate = [NSDate date];
    }
    return _datePicker;
}
@end
