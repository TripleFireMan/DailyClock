//
//
//  Created by 成焱 on 2020/9/18.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDataResumeViewController.h"

@interface DKDataResumeViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *containerTitleLbl;
@property (nonatomic, strong) UILabel *containerSubtitleLbl;
@property (nonatomic, strong) UISwitch *switcher;

@property (nonatomic, strong) UILabel *icloundLabel;
@property (nonatomic, strong) UIButton *beifenBtn;
@property (nonatomic, strong) UIButton *huifuBtn;

@property (nonatomic, strong) UILabel *lastUpdateTimeLabel;

@end

@implementation DKDataResumeViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"数据备份";

    
    NSLog(@"url : %@",[self icloudContainerBaseURL]);
}

- (NSURL *)icloudContainerBaseURL
{
    if ([NSFileManager defaultManager].ubiquityIdentityToken)
    {
        return [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    }
    
    return nil;
}

- (void) setupSubView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.container];
    [self.container addSubview:self.containerTitleLbl];
    [self.container addSubview:self.containerSubtitleLbl];
    [self.container addSubview:self.switcher];
    
    [self.scrollView addSubview:self.icloundLabel];
    [self.scrollView addSubview:self.beifenBtn];
    [self.scrollView addSubview:self.huifuBtn];
    [self.scrollView addSubview:self.lastUpdateTimeLabel];
    
}

- (void) addConstraints
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar);
        make.left.right.bottom.offset(0);
        make.width.offset(kScreenSize.width);
        make.height.offset(kScreenSize.height - CY_Height_NavBar);
    }];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.width.offset(kScreenSize.width - 40);
    }];
    
    [self.containerTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(18);
    }];
    
    [self.containerSubtitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerTitleLbl.mas_bottom).offset(10);
        make.left.offset(15);
        make.bottom.offset(-18);
    }];

    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
    
    [self.icloundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.container.mas_bottom).offset(100);
        make.left.offset(55);
    }];

    [self.beifenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.mas_equalTo(self.icloundLabel.mas_bottom).offset(30);
        make.height.offset(44);
    }];
    
    [self.huifuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.mas_equalTo(self.beifenBtn.mas_bottom).offset(15);
        make.height.offset(44);
    }];
    
    [self.lastUpdateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.huifuBtn.mas_bottom).offset(20);
    }];
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter
- (UIScrollView *) scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.delaysContentTouches = NO;
    }
    return _scrollView;
}

- (UIView *) container{
    if (!_container) {
        _container = [UIView new];
        _container.backgroundColor = DKIOS13ContainerColor();
        _container.layer.cornerRadius = 12.f;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UILabel *) containerTitleLbl{
    if (!_containerTitleLbl) {
        _containerTitleLbl = [UILabel new];
        _containerTitleLbl.font = DKBoldFont(15);
        _containerTitleLbl.textColor = DKIOS13LabelColor();
        _containerTitleLbl.text = @"自动备份数据";
    }
    return _containerTitleLbl;
}

- (UILabel *) containerSubtitleLbl{
    if (!_containerSubtitleLbl) {
        _containerSubtitleLbl = [UILabel new];
        _containerSubtitleLbl.font = DKFont(15);
        _containerSubtitleLbl.textColor = DKIOS13SecondLabelColor();
        _containerSubtitleLbl.text = @"自动每24小时备份一次数据";
    }
    return _containerSubtitleLbl;
}

- (UILabel *) icloundLabel{
    if (!_icloundLabel) {
        _icloundLabel = [UILabel new];
        _icloundLabel.font = DKBoldFont(15);
        _icloundLabel.textColor = DKIOS13SecondLabelColor();
        _icloundLabel.text = @"备份到iCloud云盘";
    }
    return _icloundLabel;
}

- (UIButton *) beifenBtn{
    if (!_beifenBtn) {
        _beifenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beifenBtn setTitle:@"备份到iCloud云盘" forState:UIControlStateNormal];
        _beifenBtn.titleLabel.font = DKFont(15);
        [_beifenBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        [_beifenBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [_beifenBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
        _beifenBtn.layer.cornerRadius = 22;
        _beifenBtn.layer.masksToBounds = YES;
        [[_beifenBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[[[[DKApplication cy_shareInstance] p_backupToICloud] then:^id _Nullable(id  _Nullable value) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"备份成功";
                [hud hideAnimated:YES afterDelay:1];
                return nil;
            }] catch:^(NSError * _Nonnull error) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"备份失败";
                [hud hideAnimated:YES afterDelay:1];
            }] always:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
                
            }];
        }];
    }
    return _beifenBtn;
}

- (void) p_save {
    
}

- (UIButton *) huifuBtn{
    if (!_huifuBtn) {
        _huifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_huifuBtn setTitle:@"从iCloud云盘恢复数据" forState:UIControlStateNormal];
        _huifuBtn.titleLabel.font = DKFont(15);
        _huifuBtn.layer.cornerRadius = 22;
        _huifuBtn.layer.masksToBounds = YES;
        [_huifuBtn setTitleColor:DKIOS13LabelColor() forState:UIControlStateNormal];
        [_huifuBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [_huifuBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
        [[_huifuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[[[[DKApplication cy_shareInstance] p_loadDataFromICloud] then:^id _Nullable(id  _Nullable value) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"恢复成功";
                [hud hideAnimated:YES afterDelay:1];
                return nil;
            }] catch:^(NSError * _Nonnull error) {
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"恢复失败";
                [hud hideAnimated:YES afterDelay:1];
            }] always:^{
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
            }];
        }];
    }
    return _huifuBtn;
}

- (UISwitch *) switcher{
    if (!_switcher) {
        _switcher = [[UISwitch alloc] init];
        _switcher.on = [DKApplication cy_shareInstance].isAutoBeifeiShuju;
        _switcher.onTintColor = kMainColor;
        [_switcher.rac_newOnChannel subscribeNext:^(NSNumber * _Nullable x) {
            BOOL isOn = [x boolValue];
            [DKApplication cy_shareInstance].isAutoBeifeiShuju = isOn;
            [[DKApplication cy_shareInstance] cy_save];
        }];
    }
    return _switcher;
}

- (UILabel *) lastUpdateTimeLabel{
    @weakify(self);
    if (!_lastUpdateTimeLabel) {
        _lastUpdateTimeLabel = [UILabel new];
        _lastUpdateTimeLabel.font = DKFont(13);
        _lastUpdateTimeLabel.textColor = DKIOS13PlaceholderTextColor();
        if ([DKApplication cy_shareInstance].lastBackupDate!=nil) {
            _lastUpdateTimeLabel.text = [NSString stringWithFormat:@"上次备份时间：%@",[[DKApplication cy_shareInstance].lastBackupDate stringWithFormat:@"yyyy-MM-dd hh:mm:ss" ]];
        }
        
        [RACObserve([DKApplication cy_shareInstance], lastBackupDate) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            NSDate *date = x;
            if (date) {
                self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"上次备份时间：%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss" ]];
            }
        }];
        
    }
    return _lastUpdateTimeLabel;
}


#pragma mark -

@end
