//
//  DKUserCenterFooter.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/17.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKUserCenterFooter.h"
@interface DKUserCenterFooter()

@property (nonatomic, strong) UILabel *versionLabel;

@end
@implementation DKUserCenterFooter

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.versionLabel = [UILabel new];
        self.versionLabel.font = DKFont(13.f);
        self.versionLabel.textColor = [UIColor darkTextColor];
        self.versionLabel.text = [NSString stringWithFormat:@"v%@",APPVersion];
        [self addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-10);
        }];
    }
    return self;
}
@end
