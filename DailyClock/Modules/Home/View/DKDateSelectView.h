//
//  DKDateSelectView.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/7.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDateSelectView : UIView

// 取消
@property (nonatomic, copy  ) CYVoidBlock cancelBlock;
// 确定
@property (nonatomic, copy  ) CYIDBlock   confirmBlock;

// 外部传进来的日期
@property (nonatomic, strong) NSDate      *date;

+ (instancetype) showOnView:(UIView *)view animated:(BOOL)animated;

- (void) hide;
- (void) configModel:(id)model;
@end

NS_ASSUME_NONNULL_END
