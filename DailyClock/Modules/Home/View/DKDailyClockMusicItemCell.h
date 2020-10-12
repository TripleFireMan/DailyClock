//
//  DKDailyClockMusicItemCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/11.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDailyClockMusicItemCell : UITableViewCell

@property (nonatomic, strong) DKReminder *reminder;


- (void) configModel:(id)model;

- (void) start;
- (void) rotate;
- (void) stop;
@end

NS_ASSUME_NONNULL_END
