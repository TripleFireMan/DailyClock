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
#import "DKTargetListViewController.h"

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
    
    DKTargetListViewController *targetList = [DKTargetListViewController new];
    UINavigationController *targetListNavi = [[UINavigationController alloc] initWithRootViewController:targetList];
    [[CYCustomTabBarController shareInstance] addChildViewController:targetListNavi title:@"目标" image:[UIImage imageNamed:@"TabBar_Target_Nor"] selectedImage:[UIImage imageNamed:@"TabBar_Target_Sel"] color:[UIColor lightGrayColor] selectedColor:[UIColor lightGrayColor]];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    tabbar.delegate = self;
    [tabbar addChildViewController:homeNavi];
    [tabbar addChildViewController:targetListNavi];
    [tabbar addChildViewController:mineNavi];
    tabbar.tabBar.tintColor = DKIOS13LabelColor();

    
    app.window.rootViewController = tabbar;
    
    [app.window makeKeyAndVisible];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    vibrate();
    NSInteger selectedIndex = tabBarController.selectedIndex;
    if (selectedIndex == 0) {
        [MobClick event:@"tab_home"];
    }
    else if (selectedIndex == 1){
        [MobClick event:@"tab_list"];
    }
    else{
        [MobClick event:@"tab_mine"];
    }
}
@end
