//
//  DKAlert.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/17.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSInteger DKAlertDone;

@interface DKAlert : NSObject
+ (void) showTitle:(NSString *)title
          subTitle:(NSString *)subTitle
       clickAction:(void(^)(NSInteger idx, NSString *idxTitle))clickAction
         doneTitle:(NSString *)done
             array:(NSArray <NSString *>*)others;
@end

NS_ASSUME_NONNULL_END
