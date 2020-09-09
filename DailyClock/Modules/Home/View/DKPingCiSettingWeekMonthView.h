//
//  DKPingCiSettingWeekMonthView.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  周和月频次设置

#import <UIKit/UIKit.h>
#import "DKTargetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKPingCiSettingWeekMonthView : UIView

- (id) initWithFrame:(CGRect)frame pingciType:(DKTargetPinCiType)type;
@property (nonatomic, strong) DKTargetModel *model;
@end

NS_ASSUME_NONNULL_END
