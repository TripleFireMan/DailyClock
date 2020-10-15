//
//  DKSharePopView.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/11.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKSharePopView.h"
#import "UITextView+ZWPlaceHolder.h"

@interface DKSharePopView ()

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
      @weakify(self);
      [self setupSubviews];
      [self addConstrainss];
      
      [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
          @strongify(self);
          NSDictionary *useinfo = [x userInfo];
          CGRect rect = [[useinfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
          CGFloat keyboardHeight = rect.size.height;
          
          [self layoutIfNeeded];
          [UIView animateWithDuration:0.35 animations:^{
              [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
                  make.centerX.offset(0);
                  make.left.offset(30);
                  make.right.offset(-35);
                  make.bottom.offset(-keyboardHeight-20);
              }];
              [self layoutIfNeeded];
          } completion:^(BOOL finished) {
          }];
      }];
      
      [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
          @strongify(self);
          
          [self layoutIfNeeded];
          [UIView animateWithDuration:0.35 animations:^{
            [self.container mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.offset(0);
                make.left.offset(30);
                make.right.offset(-30);
            }];
            [self layoutIfNeeded];
          } completion:^(BOOL finished) {
          }];
      }];
  }
  return self;
}

- (void) setupSubviews
{

    [self addSubview:self.maskView];
    [self addSubview:self.container];
    
    [self.container addSubview:self.imageView];
    [self.container addSubview:self.closeImageView];
    [self.container addSubview:self.closeBtn];
//    [self.container addSubview:self.titleLabel];
//    [self.container addSubview:self.messageLabel];
    [self.container addSubview:self.textContaierView];
    [self.textContaierView addSubview:self.textView];
    [self.container addSubview:self.confirmBtn];
//    [self.container addSubview:self.shareBtn];
}

- (void) addConstrainss
{
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.offset(30);
        make.right.offset(-30);
//        make.height.offset(800);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerX.offset(0);
        make.width.offset(293*0.8);
        make.height.offset(124*0.8f);
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
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.imageView.mas_bottom).offset(15);
//        make.centerX.offset(0);
//    }];
//
//    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
//        make.left.offset(30);
//        make.right.offset(-30);
//    }];
    
    [self.textContaierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.height.offset(100);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(15);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
//    CGFloat btnWidth = (kScreenSize.width - 30 - 60 - 15)/2.f;
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textContaierView.mas_bottom).offset(15);
//        make.left.offset(30);
        make.width.offset(kScreenSize.width - 60 -60);
        make.height.offset(40);
        make.bottom.offset(-20);
        make.centerX.offset(0);
    }];
    
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-30);
//        make.width.offset(btnWidth);
//        make.height.offset(40);
//        make.bottom.offset(-20);
//    }];
}

- (void) setTargetModel:(DKTargetModel *)targetModel
{
    _targetModel = targetModel;
    NSString *text = [NSString stringWithFormat:@"您已累计打卡%@次\n连续打卡%@次\n距离目标还剩%@次\n加油吧~~~",@([_targetModel signModels].count),@([_targetModel continueCont]),@([_targetModel targetCount])];
    
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
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10.f; // 调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSRange range = NSMakeRange(0, [text length]);
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
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
        _container.backgroundColor = DKIOS13SystemBackgroundColor();
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
        _titleLabel.textColor = DKIOS13LabelColor();
        _titleLabel.text = @"恭喜你~";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *) messageLabel{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = CYPingFangSCMedium(14);
        _messageLabel.textColor = DKIOS13ContainerColor();
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
        _textContaierView.backgroundColor = DKIOS13ContainerColor();
    }
    return _textContaierView;
}

- (UITextView *) textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.textColor = DKIOS13SecondLabelColor();
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = DKFont(14.f);
        _textView.zw_placeHolder = @"写点什么吧";
    }
    return _textView;
}

- (UIButton *) confirmBtn{
    @weakify(self);
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.layer.cornerRadius = 20.f;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:.8f]] forState:UIControlStateHighlighted];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = DKFont(16.f);
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


//- (UIButton *) shareBtn{
//    @weakify(self);
//    if (!_shareBtn) {
//        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _shareBtn.layer.cornerRadius = 20.f;
//        _shareBtn.backgroundColor =kShareBtnColor;
//        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//                @strongify(self);
//                self.signModel.text = self.textView.text;
//                self.share?self.share():nil;
//            [self hide];
//        }];
//    }
//    return _shareBtn;
//}

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
