//
//  DKSharePopView.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/11.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKSharePopView : UIView

/// 展示分享弹框
+ (instancetype) showOnView:(UIView *)aView
              confirmAction:(CYVoidBlock)confirm
                shareAction:(CYVoidBlock)share
               cancelAction:(CYVoidBlock)cancel
                targetModel:(DKTargetModel *)model
                  signModel:(DKSignModel *)signModel;
- (void) hide;
@end

NS_ASSUME_NONNULL_END
