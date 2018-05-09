//
//  YMDateTool.m
//  YueMao
//
//  Created by HEYANG on 16/5/24.
//
//

#import "YMDateTool.h"

#define kMinuteTimeInterval (60)
#define kHourTimeInterval   (60 * kMinuteTimeInterval)
#define kDayTimeInterval    (24 * kHourTimeInterval)
#define kWeekTimeInterval   (7  * kDayTimeInterval)
#define kMonthTimeInterval  (30 * kDayTimeInterval)
#define kYearTimeInterval   (12 * kMonthTimeInterval)


@implementation YMDateTool

+ (NSString*)getZodiacStrWithyyyyMMddDateStr:(NSString*)dateStr{
  //  DLog(@"对应的日期%@--%@",dateStr,[YMDateTool getZodiacStringWithDate:[YMDateTool getCurrentDateWithyyyyMMdd:dateStr]]);
    return [YMDateTool getZodiacStringWithDate:[YMDateTool getCurrentDateWithyyyyMMdd:dateStr]];
}

#pragma mark - 获取yyyyMMdd的时间或者字符串格式
+ (NSDate*)getCurrentDateWithyyyyMMdd:(NSString*)dateString{
    // 创建的格式 yyyyMMdd
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    return [dateFormatter dateFromString:dateString];
}
+ (NSString*)getCurrentDateStrWithyyyyMMdd:(NSDate*)date{
    // 创建的格式 yyyyMMdd
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark 根据NSDate获取当前年龄的方法
+ (NSString*)getCurrentAgeWithDate:(NSDate*)date{

    // 通过NSDateComponents 从 date 中提取出 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    NSInteger year = [components1 year];
    
    NSInteger month = [components1 month];
    
    NSInteger day = [components1 day];
    
    // 获取系统当前的年月日
    NSDate *currentDate = [NSDate date]; // 获得系统的时间
    
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:currentDate];
    
    NSInteger currentYear = [components2 year];
    
    NSInteger currentMonth = [components2 month];
    
    NSInteger currentDay = [components2 day];
    
    // 计算年龄
    NSInteger iAge = currentYear - year - 1;
    if ((currentMonth > month) || (currentMonth == month && currentDay >= day)) {
        iAge++;
    }
    return [[NSString alloc] initWithFormat:NSLocalizedString(@"%lu岁", @"%lu岁"),iAge];
}

#pragma mark 根据NSDate获取星座的方法
+ (NSString*)getZodiacStringWithDate:(NSDate*)date {
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    NSString *astroString = NSLocalizedString(@"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯", @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯");
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31) {
        return NSLocalizedString(@"错误日期格式!", @"错误日期格式!");
    }
    
    if(month==2 && day>29) {
        return NSLocalizedString(@"错误日期格式!!", @"错误日期格式!!");
    }
    else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return NSLocalizedString(@"错误日期格式!!!", @"错误日期格式!!!");
        }
    }
    
    result = [NSString stringWithFormat:NSLocalizedString(@"%@座", @"%@座"),[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}

/**
 *  根据NSString获取星座的方法
 */
+ (NSString *)getAstroWithBirthday:(NSString *)birthday{
    if ([birthday isEqualToString:@""] || birthday.length == 0 || (![YMDateTool conformStandardWithNumbers:birthday])) {
        return nil;
    }
    //出生月
    int month = [[birthday substringWithRange:NSMakeRange(4, 2)] intValue];
    //出生天
    int day = [[birthday substringWithRange:NSMakeRange(6, 2)] intValue];
    NSString *astroString = NSLocalizedString(@"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯", @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯");
    NSString *astroFormat = @"102123444543";
    NSString *result;
    result=[NSString stringWithFormat:NSLocalizedString(@"%@座", @"%@座"),[astroString substringWithRange:NSMakeRange(month *2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}

/**
 *  根据birthday获取星座图片
 */
+ (NSString *)doGetConstellationImageWithBirthday:(NSString *)birthday {
    
    NSString *constellation = [YMDateTool getAstroWithBirthday:birthday];
    
    NSString *imageName = @"";
    
    if ([constellation isEqualToString:NSLocalizedString(@"魔羯座", @"魔羯座")]) {
        imageName = @"mojie";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"水瓶座", @"水瓶座")]) {
        imageName = @"shuiping";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"双鱼座", @"双鱼座")]) {
        imageName = @"shuangyu";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"白羊座", @"白羊座")]) {
        imageName = @"baiyang";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"金牛座", @"金牛座")]) {
        imageName = @"jinniu";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"双子座", @"双子座")]) {
        imageName = @"shuangzi";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"巨蟹座", @"巨蟹座")]) {
        imageName = @"juxie";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"狮子座", @"狮子座")]) {
        imageName = @"shizi";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"处女座", @"处女座")]) {
        imageName = @"chunv";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"天秤座", @"天秤座")]) {
        imageName = @"tiancheng";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"天蝎座", @"天蝎座")]) {
        imageName = @"tianxie";
    }
    else if ([constellation isEqualToString:NSLocalizedString(@"射手座", @"射手座")]) {
        imageName = @"sheshou";
    }
    
    return imageName;
}

/**
 *  输入只为数字的方法
 */
+ (BOOL)conformStandardWithNumbers:(NSString *)inputString {
    NSString * regex = @"^[0-9]*$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL basicTest = [pred evaluateWithObject:inputString];
    
    return basicTest;
}


/**
*  根据返回time_t时间来转换成需要的时间
*
*  @param dateTime time_t
*
*  @return 返回时间格式的时间
*/
+ (NSString *)dateInFormat:(time_t)dateTime  {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

+ (NSString *)dateInFormat1:(time_t)dateTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

+ (NSString *)dateInFormat2:(time_t)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:NSLocalizedString(@"MM月dd日 hh:mm", @"MM月dd日 hh:mm")];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

/**
 *  转换显示时间格式:分
 */
+ (NSString *)dateInMMFormat:(time_t)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

/**
 *  转换显示时间格式:毫秒
 */
+ (NSString *)dateInSSSFormat:(double)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss:SSS"];
    
    // [formatter setDateFormat:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    //输出结果是  date = 2015-10-09 下午 20:34:05 星期五
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

/**
 *  转换显示时间格式:时分
 */
+ (NSString *)dateInHHMMFormat:(double)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

/**
 *  转换显示时间格式:月日
 */
+ (NSString *)dateInMMDDFormat:(double)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}

/**
 *  转换显示时间格式:年月日
 */
+ (NSString *)dateInYYMMDDFormat:(double)dateTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *result = [dateFormatter stringFromDate:confromTimesp];
    
    return result;
}


/**
 格式1: 刚刚，分钟前，小时前，昨天
 */
+ (NSString *)timeDescriptionWithTime:(time_t)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
   
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    interval = -interval;
    
    // 今天的消息
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    long retTime = 1.0;
    
    // 今天
    if ([date isToday]) {
    
        // 小于3分钟
        if (interval <= 60) {
            return [NSString stringWithFormat:NSLocalizedString(@"刚刚", @"刚刚")];
        }
        // 小于一小时
        else if (interval <= 3600) {
            retTime = interval / 60;
            return [NSString stringWithFormat:NSLocalizedString(@"%ld分钟前", @"%ld分钟前"), retTime];
        }
        // 小于12小时
        else if (interval <= 3600 *24) {
            retTime = interval / 3600;
            return [NSString stringWithFormat:NSLocalizedString(@"%ld小时前", @"%ld小时前"), retTime];
        }
    }
    // 昨天
    else if ([date isYesterday]) {
        return [NSString stringWithFormat:NSLocalizedString(@"昨天%@", @"昨天%@"), dateString];
    }
    // 前天
    else if ([date isBeforeYesterday]){
        return [NSString stringWithFormat:NSLocalizedString(@"前天%@", @"前天%@"), dateString];
    }
    else {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year]) {
            // 今年
            [dateFormat setDateFormat:NSLocalizedString(@"MM月dd日", @"MM月dd日")];
            NSString *mdStr = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@%@", mdStr, dateString];
        }
        else {
            // 往年
            [dateFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];;
        }
    }
    
    return nil;
}

/**
 *  格式2: 上午,昨天,前天
 */
+ (NSString *)timeDescriptWithTime:(time_t)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    interval = -interval;
    
    // 今天的消息
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [dateFormat setDateFormat:@"aHH:mm"];
    [dateFormat setAMSymbol:NSLocalizedString(@"上午", @"上午")];
    [dateFormat setPMSymbol:NSLocalizedString(@"下午", @"下午")];
    NSString *dateString = [dateFormat stringFromDate:date]; 
    
    // 今天
    if ([date isToday]) {
        return dateString;
        // return [NSString stringWithFormat:NSLocalizedString(@"今天%@", @"今天%@"), dateString];
    }
    // 昨天
    else if ([date isYesterday]) {
        return [NSString stringWithFormat:NSLocalizedString(@"昨天%@", @"昨天%@"), dateString];
    }
    // 前天
    else if ([date isBeforeYesterday]){
        return [NSString stringWithFormat:NSLocalizedString(@"前天%@", @"前天%@"), dateString];
    }
    else if (interval < kWeekTimeInterval) {
        // 最近一周
        [dateFormat setDateFormat:@"ccc"];
        NSString *weekStr = [dateFormat stringFromDate:date];
        return [NSString stringWithFormat:@"%@ %@", weekStr, dateString];
    }
    else {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year]) {
            // 今年
            [dateFormat setDateFormat:NSLocalizedString(@"MM月dd日", @"MM月dd日")];
            NSString *mdStr = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@%@", mdStr, dateString];
        }
        else {
            // 往年
            [dateFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];;
        }
    }
    return nil;
}

/**
 *  格式3: 今天,昨天,前天
 */
+ (NSString *)timeDescriptDateWithTime:(time_t)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    interval = -interval;
    
    // 今天的消息
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    // 今天
    if ([date isToday]) {
        return [NSString stringWithFormat:NSLocalizedString(@"今天%@", @"今天%@"), dateString];
    }
    // 昨天
    else if ([date isYesterday]) {
        return [NSString stringWithFormat:NSLocalizedString(@"昨天%@", @"昨天%@"), dateString];
    }
    // 前天
    else if ([date isBeforeYesterday]){
        return [NSString stringWithFormat:NSLocalizedString(@"前天%@", @"前天%@"), dateString];
    }
    else {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year]) {
            // 今年
            [dateFormat setDateFormat:NSLocalizedString(@"MM月dd日", @"MM月dd日")];
            NSString *mdStr = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@%@", mdStr, dateString];
        }
        else {
            // 往年
            [dateFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [dateFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];;
        }
    }
    
    return nil;
}

@end
