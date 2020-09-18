//
//  DataTool.h
//  来店易
//
//  Created by yejianping on 17/1/20.
//  Copyright © 2017年 u1city01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject

/**
 字典转Json字符串
 
 @param infoDict 字典数据
 @return Json字符串
 */
+ (NSString *)convertToJSONData:(id)infoDict;

/**
 JSON字符串转化为字典
 
 @param jsonString Json字符串
 @return 字典数据
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
