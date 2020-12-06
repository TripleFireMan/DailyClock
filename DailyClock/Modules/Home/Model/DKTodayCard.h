//
//Created by ESJsonFormatForMac on 20/12/06.
//

#import <Foundation/Foundation.h>

@class DKTodayCards;
@interface DKTodayCard : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray<DKTodayCards *> *data;

@end
@interface DKTodayCards : NSObject

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *wordsInfo;

@property (nonatomic, copy) NSString *url;

@end

