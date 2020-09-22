//
//  DKUserCenterHeader.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/14.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKUserCenterHeader.h"

@interface DKUserCenterHeader ()

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UILabel *namelbl;

@end

@implementation DKUserCenterHeader

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
    [self addSubview:self.icon];
    [self addSubview:self.namelbl];
}

- (void) addConstrainss
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(80);
        make.centerX.offset(0);
        make.centerY.offset(-20);
    }];
    
    [self.namelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.icon.mas_bottom).offset(15);
    }];
}

- (void) configModel:(id)model
{

}
- (UIImageView *) icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.layer.cornerRadius = 40.f;
        _icon.layer.masksToBounds = YES;
        _icon.image = [[UIImage imageNamed:@"dk_icon"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
//        if (@available(iOS 13, *)) {
//            UIColor *tintColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
//                    return [UIColor whiteColor];
//                }
//                else{
//                    return [UIColor redColor];
//                }
//            }];
//            _icon.tintColor  =tintColor;
//
//        }
    }
    return _icon;
}

- (UILabel *) namelbl{
    if (!_namelbl) {
        _namelbl = [UILabel new];
        _namelbl.font = [UIFont fontWithName:[DKApplication cy_shareInstance].fontName size:15];
        if (@available(iOS 13, *)) {
            _namelbl.textColor = [UIColor labelColor];
        } else {
            _namelbl.textColor = kSubTitleColor;
        }
        
        _namelbl.text = @"每天进步一点点";
    }
    return _namelbl;
}
@end
