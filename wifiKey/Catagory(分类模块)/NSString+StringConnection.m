//
//  NSString+StringConnection.m
//  sdktest
//
//  Created by JIMU on 15/5/11.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import "NSString+StringConnection.h"

@implementation NSString (StringConnection)

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    if (!key || [(id)key isKindOfClass:[NSNull class]]) {
        return self;
//        return [self stringByAppendingFormat:@""];
    }
    return [self stringByAppendingFormat:@"%@",key];
}
+ (NSString *)documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

#pragma mark - 获取缓存路径
+ (NSString *)cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

+ (NSString *)imageCachePath {
    NSString *path = [[self cachePath] stringByAppendingPathComponent:@"Images"];
    BOOL isDir = NO;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:path
                                                           isDirectory:&isDir];
    if (!isDir && !isDirExist) {
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                   withIntermediateDirectories:YES
                                                                    attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"success");
        }
    }
    
    return path;
}

+ (NSString *)localShoppingCartPath {
    return [[self cachePath] stringByAppendingPathComponent:@"/cart.plist"];
}

#pragma mark - 验证邮箱格式
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isValidnoNum {
    NSRegularExpression *regexpObject = [NSRegularExpression regularExpressionWithPattern:@"^[^0-9]+$"
                                                                                  options:0
                                                                                    error:NULL];
    NSRange range = [regexpObject rangeOfFirstMatchInString:self
                                                    options:0
                                                      range:NSMakeRange(0, [self length])];
    if (range.location == NSNotFound || range.length != [self length]) {
        return NO;
    }
    return YES;
}
#pragma mark - 验证手机号码格式
- (BOOL)isValidPhoneNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *mobile = @"^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
//    NSPredicate *cmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
//    NSPredicate *cuPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
//    NSPredicate *ctPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
    if ([mobilePredicate evaluateWithObject:self]) {
        return YES;
    }
    
    return NO;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

#pragma mark - 根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName {
    return [self pathWithFileName:fileName ofType:nil];
}

+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

+ (NSString *)dateWithSeconds:(NSUInteger)seconds {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *str = [NSString stringWithFormat:@"%@", date];
    NSArray *array = [str componentsSeparatedByString:@" "];
    NSString *result = [array objectAtIndex:0];
    if (array.count == 3) {
        result = [NSString stringWithFormat:@"%@ %@", result, [array objectAtIndex:1]];
    }
    return result;
}

@end
