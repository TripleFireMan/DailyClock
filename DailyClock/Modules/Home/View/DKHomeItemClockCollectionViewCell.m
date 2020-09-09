//
//  DKHomeItemClockCollectionViewCell.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/8.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKHomeItemClockCollectionViewCell.h"

@interface DKHomeItemClockCollectionViewCell()

@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation DKHomeItemClockCollectionViewCell
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self addConstraintss];
    }
    return self;
}

- (void) setupSubviews {
    
}

- (void) addConstraintss {
    
}
@end
