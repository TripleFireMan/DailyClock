//
//  CYBaseViewController+DKExtend.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "CYBaseViewController+DKExtend.h"
#import "NSObject+YYAdd.h"

@implementation CYBaseViewController (DKExtend)
+ (void) load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(dkViewDidLoad)];
    });
}

- (void)dkViewDidLoad{
    [self dkViewDidLoad];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor blackColor];
}


@end
