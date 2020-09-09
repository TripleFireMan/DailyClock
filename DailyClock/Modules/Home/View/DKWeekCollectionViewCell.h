//
//  DKWeekCollectionViewCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  星期选项

#import <UIKit/UIKit.h>
#import "DKTargetModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DKWeekCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) DKTargetPinCiWeekModel *weekModel;
@end

NS_ASSUME_NONNULL_END
