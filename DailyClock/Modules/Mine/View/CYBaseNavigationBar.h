//
//  CYBaseNavigationBar.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/16.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYBaseNavigationBar : UIView

/// 头部视图
@property (nonatomic, strong)  UIView *headerView;
@property (nonatomic, strong)  UIButton *backBtn;
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UIView *bottomLine;

@property (nonatomic, strong)  UIImageView *heaerImageView;

@property (nonatomic, copy  ) CYVoidBlock backAction;
@end

NS_ASSUME_NONNULL_END
