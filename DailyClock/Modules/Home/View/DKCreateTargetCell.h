//
//  DKCreateTargetCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//  常规cell

#import <UIKit/UIKit.h>
#import "DKTargetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKCreateTargetCell : UITableViewCell

@property (nonatomic, strong) DKTargetModel *model;

- (void) configModel:(id)model;
- (void) setupSubviews;
- (void) addConstrainss;
@end

NS_ASSUME_NONNULL_END
