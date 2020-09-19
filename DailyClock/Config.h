//
//  Config.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/12.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "CacheTool.h"

#ifndef Config_h
#define Config_h

#define KINFOPLIST(p) [CacheTool getKeyValueWithInfoPlist:(p)]
//APP外部版本号
#define APPVersion KINFOPLIST(@"CFBundleShortVersionString")
//APP应用名称
#define APPDisplayName KINFOPLIST(@"CFBundleDisplayName")

//APP BundleId
#define APPBundleId [[NSBundle mainBundle] bundleIdentifier]

#define UM_APPKEY   @"5f65c265b473963242a2a356"

#define JPushAppKey     @"feeda3c2e20b59e431cbfd43"
#define JPushChannel    @"App Store"

#endif /* Config_h */
