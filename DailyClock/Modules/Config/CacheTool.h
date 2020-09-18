//
//  CacheTool.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/8/23.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheTool : NSObject
#pragma mark - UserDefaults数据存储

/**
 UserDefaults数据保存(字典类型数据保存，先转Json字符串再保存)
 
 @param keyName 键值
 @param dictionaryObj 字典数据
 */
+ (void)saveDictionaryToUserDefaults:(NSString *)keyName dictObj:(NSDictionary *)dictObj;

/**
 UserDefaults数据读取(Json字符串转字典数据)
 
 @param keyName 键值
 @return 字典数据
 */
+ (NSDictionary *)readDictionaryFromUserDefaults:(NSString *)keyName;

/**
 UserDefaults数据保存
 
 @param keyName 键值
 @param dataObj 对象数据
 */
+ (void)saveUserDefaults:(NSString *)keyName dataObj:(id)dataObj;

/**
 UserDefaults数据读取
 
 @param keyName 键值
 @return 对象数据
 */
+ (id)readUserDefaults:(NSString *)keyName;

/**
 UserDefaults数据删除
 
 @param keyName 键值
 */
+ (void)removeUserDefaults:(NSString *)keyName;
#pragma mark - Plist文件数据存储
/**
 Plist数据保存
 
 @param plistName Plist文件名称
 @param dataObj 对象数据（NSMutableDictionary、NSArray）
 @return YES:成功 NO:失败
 */
+ (BOOL)savePlist:(NSString *)plistName dataObj:(NSObject *)dataObj;

/**
 Plist数据读取
 
 @param plistName Plist文件名称
 @param dataClass 数据类型
 @return 对象数据
 */
+ (id)readPlist:(NSString *)plistName dataClass:(Class)dataClass;

/**
 Plist数据删除
 
 @param plistName Plist文件名称
 @return YES:成功 NO:失败
 */
+ (BOOL)removePlist:(NSString *)plistName;

/**
 读取Info.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithInfoPlist:(NSString *)keyName;

/**
 读取Config.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithConfigPlist:(NSString *)keyName;

/**
 读取systemConfig.Plist里的值
 
 @param keyName 键值
 @return 健值对应的值
 */
+ (NSString *)getKeyValueWithSystemConfigPlist:(NSString *)keyName;

@end

NS_ASSUME_NONNULL_END
