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

/// 普通
@property (nonatomic, strong) NSString *fontName;
/// 粗体
@property (nonatomic, strong) NSString *boldFontName;

- (void) setup:(NSDictionary *)launchInfo;

@end

NS_ASSUME_NONNULL_END
