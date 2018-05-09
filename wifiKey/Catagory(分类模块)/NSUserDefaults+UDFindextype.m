//
//  NSUserDefaults+UDFindextype.m
//  ZhongdaBoyan
//
//  Created by JIMU on 15/4/9.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import "NSUserDefaults+UDFindextype.h"

@implementation NSUserDefaults (UDFindextype)

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    UDF_default;
    id data = [defaults objectForKey:(NSString *)key];
    if ([data isKindOfClass:[NSData class]]) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
            return obj;
        }
    }
    return data;
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
        obj = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    }
    UDF_default;
    [defaults setObject:obj forKey:(NSString *)key];
    [defaults synchronize];
}


@end
