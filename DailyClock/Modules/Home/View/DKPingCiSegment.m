//
//  DKPingCiSegment.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/4.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKPingCiSegment.h"

@interface DKPingCiSegment ()
@property (nonatomic, strong) UILabel *gudingLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *weekLabel;
@end

@implementation DKPingCiSegment

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self){
      [self setupSubviews];
      [self addConstrainss];
  }
  return self;
}

- (void) setupSubviews
{

}

- (void) addConstrainss
{

}

- (void) configModel:(id)model
{

}
@end
