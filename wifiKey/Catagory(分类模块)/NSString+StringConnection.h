//
//  NSString+StringConnection.h
//  sdktest
//
//  Created by JIMU on 15/5/11.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringConnection)
- (id)objectForKeyedSubscript:(id <NSCopying>)key;
// 获取Documents路径
+ (NSString *)documentPath;

// 获取缓存路径
+ (NSString *)cachePath;

+ (NSString *)imageCachePath;

// 本地购物车路径
+ (NSString *)localShoppingCartPath;

//! 是否是合法邮箱
- (BOOL)isValidEmail;
//! 是否包含数字
-(BOOL)isValidnoNum;
//! 是否是合法号码
- (BOOL)isValidPhoneNumber;
//! 是否是合法的18位身份证号码
- (BOOL)isValidPersonID;
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code;

//! 根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName;
+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type;

// 根据秒数返回日期
+ (NSString *)dateWithSeconds:(NSUInteger)seconds;
@end
