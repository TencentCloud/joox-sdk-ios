//
//  JXJsonHelper.h
//  QQMusic
//
//  Json工具类
//
//  Created by ethangao on 13-12-25.
//  Copyright (c) 2013年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXJsonHelper : NSObject

+ (id)getObjectFromDictionary:(NSDictionary*)dict forKey:(NSString*)key classType:(Class)classType withDefault:(NSObject*)defaultValue;
+ (NSString *)getStringFromDictionary:(NSDictionary *)dict forKey:(NSString *)key isBase64Format:(BOOL)isBase64Format;
+ (NSArray *)getArrayFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (NSInteger)getIntegerFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (int)getIntFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (int)getIntFromDictionary:(NSDictionary *)dict forKey:(NSString *)key withDefault:(int)ret;
+ (NSInteger)getIntegerFromDictionary:(NSDictionary *)dict forKey:(NSString *)key withDefault:(NSInteger)ret;
+ (double)getDoubleFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (unsigned long)getUnsignedLongFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (unsigned int)getUnsignedIntFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (unsigned int)getUnsignedIntFromDictionary:(NSDictionary *)dict forKey:(NSString *)key withDefault:(unsigned int)ret;
+ (long long)getLongLongFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (BOOL)getBoolFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (NSUInteger)getUnsignedIntegerFromDictionary:(NSDictionary *)dict forKey:(NSString *)key;

@end
