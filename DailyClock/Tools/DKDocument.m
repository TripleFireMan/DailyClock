//
//  DKDocument.m
//  DailyClock
//
//  Created by 成焱 on 2020/9/18.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import "DKDocument.h"
@interface DKDocument ()

@end
@implementation DKDocument
- (id) initWithFileURL:(NSURL *)url targetData:(nullable NSData *)data{
    self = [super initWithFileURL:url];
    if (self) {
        _data = data;
    }
    return self;
}
- (id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError{
    return self.data;
}

- (BOOL) loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing  _Nullable *)outError{
    if ([contents isKindOfClass:[NSData class]])
    {
        _data = contents;
    }
    return YES;
}
@end
