//
//  DKDailyArticleReminderView.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/9.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDailyArticleReminderView : UIView
@property (nonatomic, copy  ) CYIDBlock block;
- (void) configModel:(id)model;
- (void) reload;
@end

NS_ASSUME_NONNULL_END
