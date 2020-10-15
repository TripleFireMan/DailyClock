//
//  DKFontModel.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/19.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKFontModel.h"
#import <CoreText/CTFont.h>
#import "YYKitMacro.h"
@implementation DKFontModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"fontName":@"font_name",
             @"boldFontName":@"font_bold_name",
    };
}

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) regist{
    if (self.isDownloaded) {
        [UIFont loadFontFromPath:self.filePath];
    }
}
- (BOOL) isDownloaded{
    return [self isFontDownloaded:self.fontName];
}

- (BOOL)isFontDownloaded:(NSString *)postScriptName{
    UIFont *font = [UIFont fontWithName:postScriptName size:12];
    if (font && ([font.fontName compare:postScriptName] == NSOrderedSame || [font.familyName compare:postScriptName] == NSOrderedSame)) {
        return YES;
    }
    
    return [[NSFileManager defaultManager] fileExistsAtPath:self.filePath];
}

- (void) downloadFont{
    [self downloadFontWithPostScriptName:self.url];
}

- (NSString *) filePath{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *font_folder = [document stringByAppendingPathComponent:@"fonts"];
    BOOL isFolder = NO;
    if ([fileManger fileExistsAtPath:font_folder isDirectory:&isFolder] == NO) {
        [fileManger createDirectoryAtPath:font_folder withIntermediateDirectories:YES attributes:NULL error:NULL];
    }
    return [font_folder stringByAppendingPathComponent:[self.fontName stringByAppendingString:@".ttf"]];
}

- (void)downloadFontWithPostScriptName:(NSString *)postScriptName{
    if ([self isFontDownloaded:postScriptName]) {
        return;
    }
    if (self.isDownloading) {
        return;
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *session = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    self.isDownloading = YES;
    self.block ? self.block(@(0.0)): nil;
    [[session downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]] progress:^(NSProgress * _Nonnull downloadProgress) {
        
        self.progress = downloadProgress.fractionCompleted;
        NSLog(@"=====%@",downloadProgress);
        dispatch_async_on_main_queue(^{
            self.block ? self.block(@(self.progress)): nil;
        });
        
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:self.filePath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            dispatch_async_on_main_queue(^{
                self.isDownloading = NO;
                if (!error) {
                    self.progress = 1.0;
                    if (self.block) {
                        self.block(@(self.progress));
                    }
                    
                    NSMutableDictionary *attrsDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.fontName,kCTFontNameAttribute, nil];
                    CTFontDescriptorRef descriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrsDictionary);
                    NSMutableArray *descriptorArray = [NSMutableArray array];
                    [descriptorArray addObject:(__bridge id)descriptor];
                    CFRelease(descriptor);
                    [UIFont loadFontFromPath:self.filePath];
                }
                else{
                    [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
                    NSLog(@"error=%@",error);
                }
            });
        }] resume];
}
@end
