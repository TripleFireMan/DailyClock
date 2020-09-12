//
//
//  Created by 成焱 on 2020/9/12.
//Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKMineViewController.h"

@interface DKMineViewController ()

@end

@implementation DKMineViewController

#pragma mark - def

#pragma mark - override
- (id) init{
    self  = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"我的";
}

- (void) setupSubView
{
    
}

- (void) addConstraints
{
    
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO

#pragma mark - view event
#pragma mark 1 target-action
#pragma mark 2 delegate dataSource protocol

#pragma mark - private
#pragma mark - getter / setter

#pragma mark -

@end
