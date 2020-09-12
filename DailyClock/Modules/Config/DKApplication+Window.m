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
#import "DKMineViewController.h"

@implementation DKApplication (Window)
- (void) initwindow:(NSDictionary *)laucnInfo{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    DKHomePageViewController *home = [DKHomePageViewController new];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:home];
    [[CYCustomTabBarController shareInstance] addChildViewController:homeNavi title:@"打卡" image:[UIImage imageNamed:@"TabBar_PunchCard_Nor"] selectedImage:[UIImage imageNamed:@"TabBar_PunchCard_Sel"] color:[UIColor lightGrayColor] selectedColor:[UIColor lightGrayColor]];
    
    

    
    DKMineViewController *mine = [DKMineViewController new];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mine];
    [[CYCustomTabBarController shareInstance] addChildViewController:mineNavi title:@"我的" image:[UIImage imageNamed:@"TabBar_My_Nor"] selectedImage:[UIImage imageNamed:@"TabBar_My_Sel"] color:[UIColor lightGrayColor] selectedColor:[UIColor lightGrayColor]];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    [tabbar addChildViewController:homeNavi];
    [tabbar addChildViewController:mineNavi];
    tabbar.tabBar.tintColor = [UIColor blackColor];
    
    app.window.rootViewController = tabbar;
    
    [app.window makeKeyAndVisible];
}
@end
