//
//  DKTargetSharedViewController.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/12.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetSharedViewController.h"
#import "DKTodayCard.h"
#import <Photos/Photos.h>

@interface DKTargetSharedItemView : UIView
@property (nonatomic, strong) UIImageView *targetIcon;
@property (nonatomic, strong) UILabel *targetlabel;
@property (nonatomic, strong) UILabel *daysLabel;

- (id) initWithFrame:(CGRect)frame model:(DKTargetModel *)model;

@end

@implementation DKTargetSharedItemView

- (id) initWithFrame:(CGRect)frame model:(DKTargetModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.targetIcon];
        [self addSubview:self.targetlabel];
        [self addSubview:self.daysLabel];
        
        [self.targetIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.centerY.offset(0);
        }];
        
        [self.targetlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.targetIcon.mas_right).offset(10);
            make.top.offset(7);
            make.bottom.offset(-7);
        }];
        
        [self.daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.targetlabel.mas_right).offset(5);
            make.centerY.offset(-2);
        }];
        
        self.targetIcon.image = [UIImage imageNamed:[model.icon stringByAppendingString:@"-2"]];
        self.targetlabel.text = model.title;
        NSString *daystring = [NSString stringWithFormat:@"已坚持 %ld 天",model.signModels.count];
        NSMutableAttributedString *dayAtt = [[NSMutableAttributedString alloc] initWithString:daystring];
        dayAtt.color = DKIOS13SecondLabelColor();
        dayAtt.font = CYPingFangSCRegular(11);
        [dayAtt setFont:CYPingFangSCMedium(20) range:[daystring rangeOfString:[NSString stringWithFormat:@"%ld",model.signModels.count]]];
        [dayAtt setColor:kMainColor range:[daystring rangeOfString:[NSString stringWithFormat:@"%ld",model.signModels.count]]];
        [dayAtt setBaselineOffset:@(-0.36 * 9) range:[daystring rangeOfString:[NSString stringWithFormat:@"%ld",model.signModels.count]]];
        self.daysLabel.attributedText = dayAtt;
    }
    return self;
}

- (UIImageView *) targetIcon{
    if (!_targetIcon) {
        _targetIcon = [UIImageView new];
        _targetIcon.image = [UIImage imageNamed:@""];
    }
    return _targetIcon;
}

- (UILabel *) daysLabel{
    if (!_daysLabel) {
        _daysLabel = [UILabel new];
        _daysLabel.font = CYPingFangSCMedium(11);
        _daysLabel.textColor = DKIOS13SecondLabelColor();
        _daysLabel.text = @"";
    }
    return _daysLabel;
}

- (UILabel *) targetlabel{
    if (!_targetlabel) {
        _targetlabel = [UILabel new];
        _targetlabel.font = CYPingFangSCMedium(12);
        _targetlabel.textColor = DKIOS13LabelColor();
        _targetlabel.text = @"";
    }
    return _targetlabel;
}

@end

@interface DKTargetSharedViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *dateSecondLabel;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *wordsInfoLabel;

@property (nonatomic, strong) DKTodayCards *todayCard;

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UIButton *saveToAlbumBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *logo;

@end

@implementation DKTargetSharedViewController
- (id) init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldShowBackBtn = NO;
    self.titleLabel.text=  @"小成就";
    [self loadData];
}

- (void) setupSubView{
    [self.view addSubview:self.scrollView];
    [self.headerView addSubview:self.closeBtn];
    [self.scrollView addSubview:self.container];
    [self.container addSubview:self.imageView];
    [self.imageView addSubview:self.dateLabel];
    [self.imageView addSubview:self.dateSecondLabel];
    [self.imageView addSubview:self.logo];
    [self.container addSubview:self.stackView];
    [self.container addSubview:self.textLabel];
    [self.container addSubview:self.wordsInfoLabel];
    [self.scrollView addSubview:self.saveToAlbumBtn];
    [self.scrollView addSubview:self.shareBtn];
}

- (void) addConstraints{
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.left.offset(15);
        make.right.offset(-15);
        make.width.offset(kScreenWidth - 30);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        CGFloat rate = 500/750.f;
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(rate);
    }];
    

    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.mas_equalTo(self.dateSecondLabel.mas_top).offset(-10);
    }];
    
    [self.dateSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.offset(-15);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.mas_equalTo(self.stackView.mas_bottom).offset(40);
        make.right.offset(-15);
    }];
    
    [self.wordsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(20);
        make.bottom.offset(-15);
    }];
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.wordsInfoLabel);
//        make.top.mas_equalTo(self.wordsInfoLabel.mas_bottom).offset(8);
        make.width.height.offset(30);
        make.right.offset(-15);
        make.bottom.offset(-15);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(40);
        make.left.offset(15);
        make.right.offset(-15);
    }];
    
    CGFloat btnWidth = (kScreenWidth - 30 - 60) /2.f;
    [self.saveToAlbumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.container.mas_bottom).offset(30);
        make.left.offset(30);
        make.width.offset(btnWidth);
        make.height.offset(40);
        make.bottom.offset(-15);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.container.mas_bottom).offset(30);
        make.right.offset(-30);
        make.width.offset(btnWidth);
        make.height.offset(40);
    }];
    
}

- (void) loadData {
    // Do any additional setup after loading the view from its nib.
    [HttpTool GET:kDailyClockTodayCard parameters:nil HUD:YES success:^(id responseObject) {
        DKTodayCard *today = [DKTodayCard modelWithJSON:responseObject];
        self.todayCard = today.data.firstObject;
    } failure:^(NSError *error) {
        //
    }];
}

- (void) setTodayCard:(DKTodayCards *)todayCard{
    _todayCard = todayCard;
    [self.imageView setImageURL:[NSURL URLWithString:_todayCard.url]];
    NSInteger day = [NSDate date].weekday;
    NSInteger month = [NSDate date].month;
    NSDictionary *dayinfo = @{@1:@"日",
                              @2:@"一",
                              @3:@"二",
                              @4:@"三",
                              @5:@"四",
                              @6:@"五",
                              @7:@"六",
    };
    NSString *daystr = dayinfo[@(day)];
    NSDictionary *monthinfo = @{@1:@"一月",
                                @2:@"二月",
                                @3:@"三月",
                                @4:@"四月",
                                @5:@"五月",
                                @6:@"六月",
                                @7:@"七月",
                                @8:@"八月",
                                @9:@"九月",
                                @10:@"十月",
                                @11:@"十一月",
                                @12:@"十二月",
    };
    NSString *monthStr = monthinfo[@(month)];
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[[NSDate date] stringWithFormat:@"dd"]];
    self.dateSecondLabel.text=  [NSString stringWithFormat:@"%@ %ld",monthStr,[NSDate date].year];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:_todayCard.text?:@""];
    att.font = CYPingFangSCMedium(14);
    att.color = DKIOS13LabelColor();
    att.lineSpacing = 10.f;
    self.textLabel.attributedText = att;
    self.wordsInfoLabel.text = [NSString stringWithFormat:@"- %@",_todayCard.wordsInfo];
    
    [[self.stackView arrangedSubviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    NSArray <DKTargetModel *> *models =  [[DKTargetManager cy_shareInstance] activeModels];
    [models enumerateObjectsUsingBlock:^(DKTargetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DKTargetSharedItemView *itemView = [[DKTargetSharedItemView alloc] initWithFrame:CGRectZero model:obj];
        [self.stackView addArrangedSubview:itemView];
    }];
}


- (UIScrollView *) scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = DKIOS13ContainerColor();
    }
    return _scrollView;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor =  DKIOS13BackgroundColor();
    }
    return _container;
}

- (UIImageView *) imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@""];
    }
    return _imageView;
}

- (UILabel *) dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = CYPingFangSCMedium(30);
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.text = @"";
    }
    return _dateLabel;
}

- (UILabel *) dateSecondLabel{
    if (!_dateSecondLabel) {
        _dateSecondLabel = [UILabel new];
        _dateSecondLabel.font = CYPingFangSCMedium(20);
        _dateSecondLabel.textColor = [UIColor whiteColor];
        _dateSecondLabel.text = @"";
    }
    return _dateSecondLabel;
}


- (UILabel *) textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = CYPingFangSCMedium(14);
        _textLabel.textColor = DKIOS13LabelColor();
        _textLabel.text = @"";
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}
- (UILabel *) wordsInfoLabel{
    if (!_wordsInfoLabel) {
        _wordsInfoLabel = [UILabel new];
        _wordsInfoLabel.font = CYPingFangSCRegular(12);
        _wordsInfoLabel.textColor = DKIOS13SecondLabelColor();
        _wordsInfoLabel.text = @"";
    }
    return _wordsInfoLabel;
}


- (UIStackView *) stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 10.f;
    }
    return _stackView;
}

- (UIButton *) closeBtn{
    @weakify(self);
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"sku_btn_close"] forState:UIControlStateNormal];
        [[_closeBtn   rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            vibrate();
            [MobClick event:@"share_close"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _closeBtn;
}
- (UIImageView *) logo{
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:@"dk_icon"];
    }
    return _logo;
}

- (UIButton *) saveToAlbumBtn{
    @weakify(self);
    if (!_saveToAlbumBtn) {
        _saveToAlbumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveToAlbumBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
        _saveToAlbumBtn.titleLabel.font = DKFont(15);
        _saveToAlbumBtn.layer.cornerRadius = 20;
        _saveToAlbumBtn.layer.masksToBounds = YES;
        [_saveToAlbumBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_saveToAlbumBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [_saveToAlbumBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
        [[_saveToAlbumBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [MobClick event:@"share_save_to_album"];
            vibrate();
            [self screenShots:^(id obj) {
                [[self class] isCanVisitPhotoLibrary:^(BOOL agreen) {
                    if (agreen) {
                        UIImageWriteToSavedPhotosAlbum(obj, NULL, NULL, NULL);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            MBProgressShowWithText(@"保存相册成功");
                        });
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            MBProgressShowWithText(@"请允许访问相册，才可以保存图片");
                        });
                    }
                }];
            }];
        }];
    }
    return _saveToAlbumBtn;
}

- (UIButton *) shareBtn{
    @weakify(self);
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享到微信" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = DKFont(15);
        _shareBtn.layer.cornerRadius = 20;
        _shareBtn.layer.masksToBounds = YES;
        [_shareBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [MobClick event:@"share_share_to_wechat"];
            [self screenShots:^(id obj) {
                @strongify(self);
                dispatch_async_on_main_queue(^{
                    
                    [self p_share:obj];
                });
            }];
        }];
    }
    return _shareBtn;
}

- (void)screenShots:(CYIDBlock)block{
    UIView *shadowView = self.container;
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(shadowView.frame.size, NO, 0.f);
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 截图:实际是把layer上面的东西绘制到上下文中
    [shadowView.layer renderInContext:ctx];
    // 获取截图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    // 保存相册
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        block?block(image):nil;
    });
}

+ (void)isCanVisitPhotoLibrary:(void(^)(BOOL))result {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        result(YES);
        return;
    }
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        result(NO);
        return ;
    }
    
    if (status == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            // 回调是在子线程的
            NSLog(@"%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status != PHAuthorizationStatusAuthorized) {
                      NSLog(@"未开启相册权限,请到设置中开启");
                      result(NO);
                      return ;
                  }
                  result(YES);
            });
  
        }];
    }
}

- (void) p_share:(UIImage *)img {
    UIImage* image = img;

    NSString *text = @"分享您的小成就给好友吧~";
//
//    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id1531050825?l=zh&ls=1&mt=8"]];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    NSArray *activityItems = @[image];

    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];

    [self presentViewController:avc animated:TRUE completion:nil];

    // 选中分享类型

    [avc setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){

    // 显示选中的分享类型

    NSLog(@"act type %@",activityType);
        [hud hideAnimated:YES];
    if (completed) {

    NSLog(@"ok");

    }else {

    NSLog(@"no ok");

    }

    }];

    UIPopoverPresentationController *popover = avc.popoverPresentationController;

    if (popover) {

    popover.sourceView = self.view;

    popover.sourceRect = self.view.bounds;

    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;

    }
}

@end
