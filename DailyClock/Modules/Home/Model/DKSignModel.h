//
//  DKSignModel.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKSignModel : NSObject

/// 日期
@property (nonatomic, strong) NSDate *date;

/// 签到数据
@property (nonatomic, copy  ) NSString *text;

@end

NS_ASSUME_NONNULL_END
