//
//  DKApplication.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKApplication : NSObject

@property (nonatomic, strong) NSString *fontName;

- (void) setup:(NSDictionary *)launchInfo;

@end

NS_ASSUME_NONNULL_END
