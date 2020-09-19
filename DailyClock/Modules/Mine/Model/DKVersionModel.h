//
//  DKVersionModel.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/19.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKVersionModel : NSObject
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *date;
@end

NS_ASSUME_NONNULL_END
