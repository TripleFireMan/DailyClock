//
//  DKDailyClockTimeSettingView.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/10.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDailyClockTimeSettingView : UIView

@property (nonatomic, strong) DKTargetModel *model;
+ (instancetype) showOnView:(UIView *)aView model:(DKTargetModel *)model complete:(CYIDBlock)block;
@end
NS_ASSUME_NONNULL_END
