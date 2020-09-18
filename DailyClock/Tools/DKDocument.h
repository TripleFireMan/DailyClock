//
//  DKDocument.h
//  DailyClock
//
//  Created by 成焱 on 2020/9/18.
//  Copyright © 2020 cheng.yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKDocument : UIDocument
@property (nonatomic, strong) NSData *data;

- (id) initWithFileURL:(NSURL *)url targetData:(nullable NSData *)data;
@end

NS_ASSUME_NONNULL_END
