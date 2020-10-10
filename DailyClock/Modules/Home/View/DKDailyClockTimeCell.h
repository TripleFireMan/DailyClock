//
//  DKDailyClockTimeCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  设置页面时间cell

#import <UIKit/UIKit.h>
#import "DKReminder.h"
NS_ASSUME_NONNULL_BEGIN

@interface DKDailyClockTimeCell : UICollectionViewCell
@property (nonatomic, strong) DKReminder *model;
@end

NS_ASSUME_NONNULL_END
