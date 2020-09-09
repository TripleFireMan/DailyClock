//
//  DKApplication+Window.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication+Window.h"
#import "CYCustomTabBarController.h"
#import "DKHomePageViewController.h"
#import "AppDelegate.h"
#import "DKCreateTargetViewController.h"

@implementation DKApplication (Window)
- (void) initwindow:(NSDictionary *)laucnInfo{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    DKHomePageViewController *home = [DKHomePageViewController new];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:home];
    [[CYCustomTabBarController shareInstance] addChildViewController:homeNavi title:@"打卡" image:nil selectedImage:nil color:[UIColor whiteColor] selectedColor:[UIColor blackColor]];
    app.window.rootViewController = [CYCustomTabBarController shareInstance];
    

    
    DKCreateTargetViewController *createTarget = [DKCreateTargetViewController new];
    [[CYCustomTabBarController shareInstance] addChildViewController:createTarget title:@"任务" image:nil selectedImage:nil color:nil selectedColor:nil];
    
    [app.window makeKeyAndVisible];
}
@end
