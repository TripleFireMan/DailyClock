//
//  DKTargetManager.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKTargetManager.h"

@implementation DKTargetManager

+ (void) resetModel{
    objc_setAssociatedObject(self, @"cy_shareInstanceOBJ", nil, OBJC_ASSOCIATION_RETAIN);
}
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
    [self.items insertObject:target atIndex:0];
}

- (void) removeTarget:(DKTargetModel *)target{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uniqueId==%@",target.uniqueId];
    NSArray *result = [self.items filteredArrayUsingPredicate:predicate];
    if (result.count == 0) {
        return;
    }
    [self.items removeObject:result.firstObject];
    
}
- (NSArray<DKTargetModel *> *) activeModels{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"status==%@",@(0)];
    NSArray *result = [self.items filteredArrayUsingPredicate:pre];
    return result;
}
- (NSArray<DKTargetModel *> *) finishedModels{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"status==%@",@(2)];
    NSArray *result = [self.items filteredArrayUsingPredicate:pre];
    return result;
}
- (NSArray<DKTargetModel *> *) cancelModels{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"status==%@",@(1)];
    NSArray *result = [self.items filteredArrayUsingPredicate:pre];
    return result;
}
@end
