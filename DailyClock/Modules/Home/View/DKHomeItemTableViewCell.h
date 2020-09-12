//
//  DKHomeItemTableViewCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/7.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKTargetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKHomeItemTableViewCell : UITableViewCell

@property (nonatomic, strong) DKTargetModel *model;

@property (nonatomic, copy  ) CYIDBlock clickBlock;

+ (CGSize) itemSize;

- (void) configModel:(id)model;

@end

NS_ASSUME_NONNULL_END
