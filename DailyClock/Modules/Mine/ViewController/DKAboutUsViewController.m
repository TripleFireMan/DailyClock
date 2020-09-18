//
//
//  Created by 成焱 on 2020/9/17.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKAboutUsViewController.h"

@interface DKAboutUsViewController ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *slogenLabel;
@property (nonatomic, strong) UILabel *versionLabel;

@end

@implementation DKAboutUsViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"关于我们";
}

- (void) setupSubView
{
    [self.view addSubview:self.icon];
    [self.view addSubview:self.namelabel];
    [self.view addSubview:self.slogenLabel];
    [self.view addSubview:self.versionLabel];
}

- (void) addConstraints
{
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.height.offset(80);
        make.bottom.mas_equalTo(self.namelabel.mas_top).offset(-10);
    }];
    
    [self.slogenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.namelabel.mas_bottom).offset(20);
        make.centerX.offset(0);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-CY_Height_Bottom_SafeArea - 20);
        make.centerX.offset(0);
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
- (UIImageView *) icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"dk_icon"];
//        _icon.layer.borderColor = [UIColor darkTextColor].CGColor;
//        _icon.layer.borderWidth = 1;
//        _icon.layer.cornerRadius = 40.f;
    }
    return _icon;
}

- (UILabel *) namelabel{
    if (!_namelabel) {
        _namelabel = [UILabel new];
        _namelabel.font = DKFont(17);
        _namelabel.textColor = kTitleColor;
        _namelabel.text = @"极简打卡";
    }
    return _namelabel;
}

- (UILabel *) slogenLabel{
    if (!_slogenLabel) {
        _slogenLabel = [UILabel new];
        _slogenLabel.font = DKFont(15);
        _slogenLabel.textColor = kSubTitleColor;
        _slogenLabel.text = @"每天进步一点点";
    }
    return _slogenLabel;
}

- (UILabel *) versionLabel{
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        _versionLabel.font = DKFont(15.f);
        _versionLabel.textColor = [UIColor darkTextColor];
        _versionLabel.text = [NSString stringWithFormat:@"版本：%@",APPVersion];
    }
    return _versionLabel;
}
#pragma mark -

@end
