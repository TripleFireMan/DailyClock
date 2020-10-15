//
//  DKFontCell.h
//  DailyClock
//
//  Created by 成焱 on 2020/10/14.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DKFontModel;
@interface DKFontCell : UITableViewCell

@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UIButton *donwloadBtn;
@property (nonatomic, strong) DKFontModel *font;
- (void) configModel:(id)model;

@end

NS_ASSUME_NONNULL_END
