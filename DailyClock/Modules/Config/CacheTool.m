//
//  CacheTool.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/8/23.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "CacheTool.h"
#import "DataTool.h"

@implementation CacheTool
#pragma mark - UserDefaults数据存储

/**
 UserDefaults数据保存(字典类型数据保存，先转Json字符串再保存)
 
 @param keyName 键值
 @param dictionaryObj 字典数据
 */
+ (void)saveDictionaryToUserDefaults:(NSString *)keyName dictObj:(NSDictionary *)dictObj {
    if(dictObj != nil && [dictObj count] > 0){
        //字典转Json字符串
        NSString *stringObj = [DataTool convertToJSONData:dictObj];
        
        [self saveUserDefaults:keyName dataObj:stringObj];
    }
}

/**
 UserDefaults数据读取(Json字符串转字典数据)
 
 @param keyName 键值
 @return 字典数据
 */
+ (NSDictionary *)readDictionaryFromUserDefaults:(NSString *)keyName {
    id dataObj = [self readUserDefaults:keyName];
    if ([dataObj isKindOfClass:[NSDictionary class]]) {
        return dataObj;
    }
    if ([dataObj isKindOfClass:[NSString class]]) {
        return [DataTool dictionaryWithJsonString:dataObj];
    }
    return nil;
}

/**
 UserDefaults数据保存
 
 @param keyName 键值
 @param dataObj 对象数据
 */
+ (void)saveUserDefaults:(NSString *)keyName dataObj:(id)dataObj {
    //转换为NSData
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dataObj forKey:keyName];
    [archiver finishEncoding];
    
    //本地保存NSData数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:keyName];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}

/**
 UserDefaults数据读取
 
 @param keyName 键值
 @return 对象数据
 */
+ (id)readUserDefaults:(NSString *)keyName {
    //查询本地数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableData *dicData = [defaults objectForKey:keyName];//根据键值取出数据
    id dataObj = nil;
    if(dicData != nil){
        //转换为NSDictionary
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dicData];
        dataObj = [unarchiver decodeObjectForKey:keyName];
        [unarchiver finishDecoding];
    }
    return dataObj;
}

/**
 UserDefaults数据删除
 
 @param keyName 键值
 */
+ (void)removeUserDefaults:(NSString *)keyName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:keyName];
    [defaults synchronize];
}
#pragma mark - Plist文件数据存储
/**
 Plist数据保存
 
 @param plistName Plist文件名称
 @param dataObj 对象数据（NSMutableDictionary、NSArray）
 @return YES:成功 NO:失败
 */
+ (BOOL)savePlist:(NSString *)plistName dataObj:(NSObject *)dataObj {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:plistName];
    if ([dataObj isKindOfClass:[NSMutableDictionary class]]) {
        return [((NSMutableDictionary *)dataObj) writeToFile:plistPath atomically:YES];
    }
    else if ([dataObj isKindOfClass:[NSArray class]]) {
        return [((NSArray *)dataObj) writeToFile:plistPath atomically:YES];
    }
    else {
        return NO;
    }
}

/**
 Plist数据读取
 
 @param plistName Plist文件名称
 @param dataClass 数据类型
 @return 对象数据
 */
+ (id)readPlist:(NSString *)plistName dataClass:(Class)dataClass {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:plistName];
    if ([dataClass isSubclassOfClass:[NSMutableDictionary class]]) {
        return [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    else if ([dataClass isSubclassOfClass:[NSArray class]]) {
        return [NSMutableArray arrayWithContentsOfFile:plistPath];
    }
    else {
        return nil;
    }
}

/**
 Plist数据删除
 
 @param plistName Plist文件名称
 @return YES:成功 NO:失败
 */
+ (BOOL)removePlist:(NSString *)plistName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:plistName];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:plistPath]) {
        [fileManager removeItemAtPath:plistPath error:nil];
    }
    return YES;
}

/**
 读取Info.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithInfoPlist:(NSString *)keyName {
    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    return [dict objectForKey:keyName];
}

/**
 读取Config.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithConfigPlist:(NSString *)keyName {
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config.plist" ofType:nil]];
    return [dict objectForKey:keyName];
}

/**
 读取systemConfig.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithSystemConfigPlist:(NSString *)keyName {
    NSString *resultValue = @"";
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"systemConfig.plist" ofType:nil]];
    if(dict != nil) {
        NSDictionary *resultDict = [dict objectForKey:keyName];
        if(resultDict != nil){
            resultValue = [resultDict objectForKey:@"Value"];//值的key，默认都是：Value
        }
    }
    return resultValue;
}

@end
