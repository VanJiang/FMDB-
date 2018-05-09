//
//  YMDateTool.h
//  YueMao
//
//  Created by HEYANG on 16/5/24.
//
//

#import <Foundation/Foundation.h>

@interface YMDateTool : NSObject

/** 根据时间yyyyMMdd字符串获取星座 */
+ (NSString*)getZodiacStrWithyyyyMMddDateStr:(NSString*)dateStr;

/** 获取yyyyMMdd的时间或者字符串格式 */
+ (NSDate*)getCurrentDateWithyyyyMMdd:(NSString*)dateString;
+ (NSString*)getCurrentDateStrWithyyyyMMdd:(NSDate*)date;

/**
 *  根据选择器获取当前年龄的方法
 */
+ (NSString*)getCurrentAgeWithDate:(NSDate*)date;

/**
 *  根据NSDate获取星座的方法
 */
+ (NSString*)getZodiacStringWithDate:(NSDate*)date;


/**
 *  根据NSString获取星座的方法
 */
+ (NSString *)getAstroWithBirthday:(NSString *)birthday;

/**
 *  根据birthday获取星座图片名称
 *
 *  @param birthday birthday
 *
 *  @return 星座图片名称
 */
+ (NSString *)doGetConstellationImageWithBirthday:(NSString *)birthday;


/**
 *  根据返回time_t时间来转换成需要的时间
 *
 *  @param dateTime time_t
 *
 *  @return 返回时间格式的时间
 */
+ (NSString *)dateInFormat:(time_t)dateTime;
+ (NSString *)dateInFormat1:(time_t)dateTime;
+ (NSString *)dateInFormat2:(time_t)dateTime;

/**
 *  转换显示时间格式:分
 */
+ (NSString *)dateInMMFormat:(time_t)dateTime;

/**
 *  转换显示时间格式:毫秒
 */
+ (NSString *)dateInSSSFormat:(double)dateTime;

/**
 *  转换显示时间格式:时分
 */
+ (NSString *)dateInHHMMFormat:(double)dateTime;

/**
 *  转换显示时间格式:日月
 */
+ (NSString *)dateInMMDDFormat:(double)dateTime;

/**
 *  转换显示时间格式:年月日
 */
+ (NSString *)dateInYYMMDDFormat:(double)dateTime;

/**
 格式1: 刚刚，分钟前，小时前，昨天
 *
 *  转换显示时间格式(秒)
 */
+ (NSString *)timeDescriptionWithTime:(time_t)time;

/**
 *  格式2: 上午,昨天,前天
 *
 *  转换显示时间格式(秒)
 */
+ (NSString *)timeDescriptWithTime:(time_t)time;

/**
 *  格式3: 今天,昨天,前天
 *
 *  转换显示时间格式(秒)
 */
+ (NSString *)timeDescriptDateWithTime:(time_t)time;

@end
