//
//  DKApplication.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/3.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKApplication.h"
#import "DKApplication+Extension.h"

@implementation DKApplication

- (NSString *) fontName{
    if (!_fontName) {
        _fontName = @"HappyZcool-2016";
//        _fontName = @"PingFangSC-Regular";
        
    }
    return _fontName;
}

- (NSString *) boldFontName{
    if (!_boldFontName) {
        _boldFontName = @"HappyZcool-2016";
//        _fontName = @"PingFangSC-Medium";
    }
    return _boldFontName;
}

- (void)setup:(NSDictionary *)launchInfo{
    [self initwindow:launchInfo];
    [self configJPush:launchInfo];
}

@end
