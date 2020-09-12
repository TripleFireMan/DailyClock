//
//  DKApplication+JPush.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/12.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKApplication (JPush)
- (void)configJPush:(NSDictionary *)launchInfo;
@end

NS_ASSUME_NONNULL_END
