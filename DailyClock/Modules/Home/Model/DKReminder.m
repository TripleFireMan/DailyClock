//
//  DKReminder.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKReminder.h"

@implementation DKReminder
- (id) init{
    self = [super init];
    if (self) {
        self.dayOfWeeks = @"每一天";
        self.duration = DKTargetDuration_EveryDay;
        
    }
    return self;
}
@end
