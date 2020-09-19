//
//Created by ESJsonFormatForMac on 20/09/19.
//

#import <Foundation/Foundation.h>


@interface DKResultObject : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *data;

@end
