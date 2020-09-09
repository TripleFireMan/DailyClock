//
//  DKTargetManager.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  目标管理类

#import <Foundation/Foundation.h>
#import "DKTargetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DKTargetManager : NSObject

@property (nonatomic, strong) NSMutableArray <DKTargetModel *> * items;

- (void) addTarget:(DKTargetModel *)target;
- (void) removeTarget:(DKTargetModel *)target;
@end

NS_ASSUME_NONNULL_END
