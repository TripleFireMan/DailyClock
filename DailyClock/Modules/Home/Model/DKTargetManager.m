//
//  DKTargetManager.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetManager.h"

@implementation DKTargetManager
- (NSMutableArray <DKTargetModel *> *) items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void) addTarget:(DKTargetModel *)target{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uniqueId==%@",target.uniqueId];
    NSArray *result = [self.items filteredArrayUsingPredicate:predicate];
    if (result.count != 0) {
        return;
    }
    [self.items addObject:target];
}

- (void) removeTarget:(DKTargetModel *)target{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uniqueId==%@",target.uniqueId];
    NSArray *result = [self.items filteredArrayUsingPredicate:predicate];
    if (result.count == 0) {
        return;
    }
    [self.items removeObject:result.firstObject];
    
}
@end
