//
//  DKSharePopView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/11.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKSharePopView.h"

@interface DKSharePopView ()
{
    /// 打卡心情
    UIImageView *_xqImgView[3];
}

/// 背景
@property (nonatomic, strong) UIView *maskView;
/// 容器
@property (nonatomic, strong) UIView *container;
/// 打卡成功图片
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *closeImageView;


@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

/// 文本容器
@property (nonatomic, strong) UIView *textContaierView;
/// 输入文本
@property (nonatomic, strong) UITextView *textView;
/// 确认按钮
@property (nonatomic, strong) UIButton *confirmBtn;
/// 分享按钮
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) DKTargetModel *targetModel;
@property (nonatomic, strong) DKSignModel *signModel;
@property (nonatomic, copy  ) CYVoidBlock confirm;
@property (nonatomic, copy  ) CYVoidBlock share;
@property (nonatomic, copy  ) CYVoidBlock cancel;
@end

@implementation DKSharePopView

+ (instancetype) showOnView:(UIView *)aView confirmAction:(CYVoidBlock)confirm shareAction:(CYVoidBlock)share cancelAction:(CYVoidBlock)cancel targetModel:(DKTargetModel *)model signModel:(nonnull DKSignModel *)signModel{
    DKSharePopView *popView = [DKSharePopView new];
    popView.targetModel = model;
    popView.maskView.alpha = 0.f;
    popView.share = share;
    popView.cancel = cancel;
    popView.confirm = confirm;
    popView.signModel = signModel;
    [aView addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    popView.container.transform = CGAffineTransformMakeScale(0.2, 0.2);
    popView.container.alpha = 0.0;
    [UIView animateWithDuration:0.35 animations:^{
        popView.maskView.alpha = 1.0;
        popView.container.alpha = 1.0;
        popView.container.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    return popView;
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

- (void) setupSubviews
{
    @weakify(self);
    [self addSubview:self.maskView];
    [self addSubview:self.container];
    
    _xqImgView[0] = [UIImageView new];
    _xqImgView[0].image = [UIImage imageNamed:@"gj_commentbmy_unselect"];
    _xqImgView[0].highlightedImage = [UIImage imageNamed:@"gj_commentbmy"];
    _xqImgView[0].userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        self->_xqImgView[0].highlighted = NO;
        self->_xqImgView[1].highlighted = NO;
        self->_xqImgView[2].highlighted = NO;
        
        self->_xqImgView[0].highlighted = YES;
        self.signModel.xq = DKSignXQType_Sad;
    }];
    tap1.numberOfTapsRequired = 1;
    
    [_xqImgView[0] addGestureRecognizer:tap1];

    
    _xqImgView[1] = [UIImageView new];
    _xqImgView[1].image = [UIImage imageNamed:@"gj_commentyb_unselect"];
    _xqImgView[1].highlightedImage = [UIImage imageNamed:@"gj_commentyb"];
    _xqImgView[1].userInteractionEnabled = YES;
    _xqImgView[1].highlighted = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        self->_xqImgView[0].highlighted = NO;
        self->_xqImgView[1].highlighted = NO;
        self->_xqImgView[2].highlighted = NO;
        
        self->_xqImgView[1].highlighted = YES;
        self.signModel.xq = DKSignXQType_Normal;
    }];
    tap2.numberOfTapsRequired = 1;
    
    [_xqImgView[1] addGestureRecognizer:tap2];
    
    
    _xqImgView[2] = [UIImageView new];
    _xqImgView[2].image = [UIImage imageNamed:@"gj_commenthp_unselect"];
    _xqImgView[2].highlightedImage = [UIImage imageNamed:@"gj_commenthp"];
    _xqImgView[2].userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        self->_xqImgView[0].highlighted = NO;
        self->_xqImgView[1].highlighted = NO;
        self->_xqImgView[2].highlighted = NO;
        
        self->_xqImgView[2].highlighted = YES;
        self.signModel.xq = DKSignXQType_Hp;
    }];
    tap3.numberOfTapsRequired = 1;
    
    [_xqImgView[2] addGestureRecognizer:tap3];
    
    [self.container addSubview:_xqImgView[0]];
    [self.container addSubview:_xqImgView[1]];
    [self.container addSubview:_xqImgView[2]];
    
    [self.container addSubview:self.imageView];
    [self.container addSubview:self.closeImageView];
    [self.container addSubview:self.closeBtn];
    [self.container addSubview:self.titleLabel];
    [self.container addSubview:self.messageLabel];
    [self.container addSubview:self.textContaierView];
    [self.textContaierView addSubview:self.textView];
    [self.container addSubview:self.confirmBtn];
    [self.container addSubview:self.shareBtn];
}

- (void) addConstrainss
{
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.offset(15);
        make.right.offset(-15);
//        make.height.offset(800);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerX.offset(0);
    }];
    
    [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(10);
        make.width.height.offset(20);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.offset(0);
       make.top.offset(0);
       make.width.height.offset(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.offset(30);
        make.right.offset(-30);
    }];
    
    [self->_xqImgView[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(15);
        make.width.height.offset(32.5);
    }];

    [self->_xqImgView[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_xqImgView[1].mas_left).offset(-30);
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(15);
        make.width.height.offset(32.5);
    }];
    
    [self->_xqImgView[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_xqImgView[1].mas_right).offset(30);
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(15);
        make.width.height.offset(32.5);
    }];
    
    [self.textContaierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.height.offset(40);
        make.top.mas_equalTo(self->_xqImgView[1].mas_bottom).offset(15);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    CGFloat btnWidth = (kScreenSize.width - 30 - 60 - 15)/2.f;
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textContaierView.mas_bottom).offset(15);
        make.left.offset(30);
        make.width.offset(btnWidth);
        make.height.offset(40);
        make.bottom.offset(-20);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-30);
        make.width.offset(btnWidth);
        make.height.offset(40);
        make.bottom.offset(-20);
    }];
}

- (void) setTargetModel:(DKTargetModel *)targetModel
{
    _targetModel = targetModel;
    NSString *text = [NSString stringWithFormat:@"您已累计打卡%@次,连续打卡%@次,距离目标还剩%@次,加油吧~~~",@([_targetModel signModels].count),@([_targetModel continueCont]),@([_targetModel targetCount])];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:text];
    att.font = CYPingFangSCMedium(14.f);
    att.color = kTitleColor;
    
    NSRange range1 = [text rangeOfString:[NSString stringWithFormat:@"累计打卡%@",@([_targetModel signModels].count).stringValue]];
    range1.location = range1.location + 4;
    range1.length = range1.length - 4;

    NSRange range2 = [text rangeOfString:[NSString stringWithFormat:@"连续打卡%@",@([_targetModel continueCont]).stringValue]];
    range2.location = range2.location + 4;
    range2.length = range2.length - 4;
    
    NSRange range3 = [text rangeOfString:[NSString stringWithFormat:@"目标还剩%@",@([_targetModel targetCount]).stringValue]];
    range3.location = range3.location + 4;
    range3.length = range3.length - 4;
    
    [att setColor:kMainColor range:range1];
    [att setColor:kMainColor range:range2];
    [att setColor:kMainColor range:range3];
    
    self.messageLabel.attributedText = att;
    
}

- (UIView *) maskView{
    @weakify(self)
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            [self hide];
        }];
        tap.numberOfTapsRequired = 1;
        _maskView.userInteractionEnabled = YES;
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.shadowColor = RGBColor(100, 100, 100).CGColor;
        _container.layer.shadowOpacity = 1;
        _container.layer.cornerRadius = 12.f;
    }
    return _container;
}

- (UIImageView *) imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"top"];
    }
    return _imageView;
}

- (UIImageView *) closeImageView{
    if (!_closeImageView) {
        _closeImageView = [UIImageView new];
        _closeImageView.image = [UIImage imageNamed:@"sku_btn_close"];
    }
    return _closeImageView;
}

- (UILabel *) titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYPingFangSCMedium(18);
        _titleLabel.textColor = kTitleColor;
        _titleLabel.text = @"恭喜你~";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *) messageLabel{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = CYPingFangSCMedium(14);
        _messageLabel.textColor = kSubTitleColor;
        _messageLabel.text = @"您已累计打卡10次，连续打卡5次，距离目标还要10次，加油吧~~~";
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (UIView *) textContaierView{
    if (!_textContaierView) {
        _textContaierView = [UIView new];
        _textContaierView.layer.cornerRadius = 6.f;
        _textContaierView.backgroundColor = kContainerColor;
    }
    return _textContaierView;
}

- (UITextView *) textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = CYPingFangSCRegular(14.f);
    }
    return _textView;
}

- (UIButton *) confirmBtn{
    @weakify(self);
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.layer.cornerRadius = 20.f;
        _confirmBtn.backgroundColor =kShareBtnColor;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.signModel.text = self.textView.text;
            self.confirm?self.confirm():nil;
            [self hide];
        }];
    }
    return _confirmBtn;
}


- (UIButton *) shareBtn{
    @weakify(self);
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.layer.cornerRadius = 20.f;
        _shareBtn.backgroundColor =kShareBtnColor;
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                self.signModel.text = self.textView.text;
                self.share?self.share():nil;
            [self hide];
        }];
    }
    return _shareBtn;
}

- (UIButton *) closeBtn{
    @weakify(self);
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn .backgroundColor = [UIColor clearColor];
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.cancel? self.cancel() :nil;
            [self hide];
        }];
    }
    return _closeBtn;
}

- (void) hide{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.maskView.alpha = 0.f;
        self.container.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.container.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
