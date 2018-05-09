//
//  NSMutableDictionary+SMC.m
//  SMCKit
//
//  Created by Sim on 13-4-18.
//  Copyright (c) 2013年 3gtv.net. All rights reserved.
//

#import "NSMutableDictionary+SMC.h"

@implementation NSMutableDictionary (SMC)

-(void)smc_setObject:(id)obj forKey:(id<NSCopying>)key
{
    if (obj == nil) {
        return;
    }
    [self setObject:obj forKey:key];
}

-(void)smc_setInterge:(NSInteger)intNum forKey:(id<NSCopying>)key
{
    id num = SMCIntToNumber(intNum);
    [self setObject:num forKey:key];
}

-(void)smc_setFloat:(float)floatNum forKey:(id<NSCopying>)key
{
    id num = SMCFloatToNumber(floatNum);
    [self setObject:num forKey:key];
}

-(void)smc_setLong:(long)longNum forKey:(id<NSCopying>)key
{
    id num = SMCLongToNumber(longNum);
    [self setObject:num forKey:key];
}

//-(void)smc_setDate:(NSDate *)date forKey:(id<NSCopying>)key
//{
//    if (!date) {
//        return;
//    }
//    NSString *dtstr = [date smc_ToString];
//    if (dtstr) {
//        [self setObject:dtstr forKey:key];
//    }
//}
@end
