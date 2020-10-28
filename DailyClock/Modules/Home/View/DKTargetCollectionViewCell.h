//
//  DKTargetCollectionViewCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/28.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKTargetCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) DKTargetModel *model;
@property (nonatomic, strong) UIView *iconContainer;
@property (nonatomic, strong) UIImageView   *iconImageView;
@property (nonatomic, strong) UILabel       *textLabel;
@property (nonatomic, copy  ) CYIDBlock clickBlock;

/// 做动画
- (void) animate;

@end

NS_ASSUME_NONNULL_END
