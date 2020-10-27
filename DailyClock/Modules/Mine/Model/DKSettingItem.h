//
//  DKSettingItem.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/27.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DKSettingItemType) {
    DKSettingItem_AboutUs,
    DKSettingItem_UserProtocol,
    DKSettingItem_PrivateProtocol,
    DKSettingItem_RecommendUS,
    DKSettingItem_FontSetting,
    DKSettingItem_Vibrate,
    DKSettingItem_MusicForClock,
};

@interface DKSettingItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL hasSwitch;
@property (nonatomic, assign) BOOL hasArrow;
@property (nonatomic, assign) DKSettingItemType settingType;
@property (nonatomic, assign) BOOL isOn;
+ (NSArray <DKSettingItem *> *) allSettings;

@end

NS_ASSUME_NONNULL_END
