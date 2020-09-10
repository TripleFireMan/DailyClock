//
//  DKHomeItemClockCollectionViewCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/8.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  首页打卡cell

#import <UIKit/UIKit.h>
#import "DKTargetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKHomeItemClockCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) DKTargetPinCiWeekModel *weekModel;
@property (nonatomic, strong) DKTargetModel *model;
@end

NS_ASSUME_NONNULL_END
