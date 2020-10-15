//
//  DKFontModel.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/19.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN


@interface DKFontModel : NSObject <YYModel>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fontName;
@property (nonatomic, copy) NSString *boldFontName;
@property (nonatomic, copy) NSString *url;

/// 本地存放的文件路径
@property (nonatomic, copy, readonly) NSString *filePath;


@property (nonatomic, assign) BOOL isDownloaded;
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) CYNumberBlock block;

/// 注册
- (void) regist;
/// 下载
- (void) downloadFont;

@end

NS_ASSUME_NONNULL_END
