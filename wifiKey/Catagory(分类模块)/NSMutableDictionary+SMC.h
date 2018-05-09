//
//  NSMutableDictionary+SMC.h
//  SMCKit
//
//  Created by Sim on 13-4-18.
//  Copyright (c) 2013年 3gtv.net. All rights reserved.
//
#define SMCIntToNumber(value)     [NSNumber numberWithInt:value]
#define SMCLongToNumber(value)    [NSNumber numberWithLong:value]
#define SMCFloatToNumber(value)   [NSNumber numberWithFloat:value]
#define SMCBoolToNumber(value)    [NSNumber numberWithBool:value]
#import <Foundation/Foundation.h>
//#import "SMCUtil.h"

@interface NSMutableDictionary (SMC)

-(void)smc_setObject:(id)obj forKey:(id<NSCopying>)key;
-(void)smc_setInterge:(NSInteger)intNum forKey:(id<NSCopying>)key;
-(void)smc_setFloat:(float)floatNum forKey:(id<NSCopying>)key;
-(void)smc_setLong:(long)longNum forKey:(id<NSCopying>)key;
//-(void)smc_setDate:(NSDate *)date forKey:(id<NSCopying>)key;
@end
