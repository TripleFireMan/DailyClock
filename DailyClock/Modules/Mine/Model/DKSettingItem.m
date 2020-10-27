//
//  DKSettingItem.m
//  DailyClock
//
//  Created by 成焱 on 2020/10/27.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKSettingItem.h"

@implementation DKSettingItem
+ (NSArray <DKSettingItem *> *) allSettings{
    NSMutableArray *items = @[].mutableCopy;
    NSArray *titles = @[@"关于我们",@"用户协议",@"隐私协议",@"给我们好评",@"字体设置",@"震动反馈",@"打卡音效"];
    [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DKSettingItem *Item = [DKSettingItem new];
        Item.title = obj;
        Item.settingType = idx;
        Item.hasArrow = YES;
        if (Item.settingType == DKSettingItem_MusicForClock ||
            Item.settingType == DKSettingItem_Vibrate) {
            Item.hasSwitch = YES;
            Item.hasArrow = NO;
            Item.isOn = YES;
        }
        [items addObject:Item];
    }];
    return items;
}
@end
