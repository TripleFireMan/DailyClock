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
        [self swizzleInstanceMethod:@selector(backbtn) with:@selector(dkbackbtn)];
    });
}

- (void)dkViewDidLoad{
    [self dkViewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = DKIOS13BackgroundColor();
        self.headerView.backgroundColor = DKIOS13BackgroundColor();
        self.titleLabel.textColor = [UIColor labelColor];
        self.backBtn.tintColor = [UIColor labelColor];
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
        self.view.overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = [UIColor whiteColor];
        self.headerView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.backBtn.tintColor = [UIColor darkGrayColor];
    }
    
    self.titleLabel.font = [UIFont fontWithName:[DKApplication cy_shareInstance].boldFontName size:18.f];
}

- (void)dkbackbtn{
    vibrate();
    [self dkbackbtn];
}


@end
