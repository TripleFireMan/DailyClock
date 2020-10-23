//
//  Created by 成焱 on 2020/9/4.
//Copyright © 2020 cheng.yan. All rights reserved.
//  目标设置页面

#import "CYBaseViewController.h"
#import "DKTargetModel.h"

typedef NS_ENUM(NSInteger, DKTargetSettingType){
    DKTargetSettingType_Insert,     // 新增
    DKTargetSettingType_Modifier,   //编辑
};

@interface DKTargetSettingViewController: CYBaseViewController

+ (instancetype) initWithTargetType:(DKTargetSettingType)type model:(DKTargetModel *)model;

#pragma mark- as

#pragma mark- model

#pragma mark- view

#pragma mark- api

@end
