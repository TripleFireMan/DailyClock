//
//  DKApplication.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication.h"
#import "DKApplication+Extension.h"

@implementation DKApplication

- (void)setup:(NSDictionary *)launchInfo{
    [self initwindow:launchInfo];
    [self configJPush:launchInfo];
}

@end
