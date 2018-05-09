//
//  NSDictionary+SMC.m
//  SMCKit
//
//  Created by Ren JianSheng on 11-11-8.
//  Copyright (c) 2011年 3gtv.net. All rights reserved.
//

#import "NSDictionary+SMC.h"
//#import "SMCUtil.h"

@implementation NSDictionary (SMC)

+(NSDictionary*)initFromJSONObject:(NSString *)json
{
    Class JSONSerialization = NSClassFromString(@"NSJSONSerialization");
    if (JSONSerialization) {
        NSError *error = nil;
        id object = [JSONSerialization
                     JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                     options:NSJSONReadingAllowFragments
                     error:&error];
        
        if (error) {
            return nil;
        }
        if ([object isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary*)object;
        }
    }
    return nil;
}

- (NSString *)smc_stringForKey:(id)key {
    if(![self smc_hasObjectForKey:key]){
        return nil;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]]) {
        return nil;
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    return object;
}


- (NSInteger)smc_intForKey:(id)key {
    if(![self smc_hasObjectForKey:key]){
        return -999;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]] ) {
//        SMCLog(@"key:%@为空", key);
        return -999;
    }
    return [object intValue];
}

- (CGFloat)smc_floatForKey:(id)key {
    if(![self smc_hasObjectForKey:key]){
        return 0;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]]) {
//        SMCLog(@"key:%@为空", key);
        return -999;
    }
    return [object floatValue];
}
- (id)smc_ObjectForKey:(id)key {
    if(![self smc_hasObjectForKey:key]){
        return nil;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]]) {
        //        SMCLog(@"key:%@为空", key);
        return nil;
    }
    return object;
}
- (BOOL)smc_boolForKey:(id)key {
    if(![self smc_hasObjectForKey:key]){
        return NO;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]]) {
//        SMCLog(@"key:%@为空", key);
        return NO;
    }
    return [object boolValue];
}

- (long)smc_longForKey:(id)key
{
    if(![self smc_hasObjectForKey:key]){
       return -999;
    }
    id object = [self objectForKey:key];
    if (object == nil || [object isEqual:[NSNull null]]) {
        return -999;
    }
    return [object longValue];
}

-(NSDate*)smc_dateForKey:(id)key
{
    if(![self smc_hasObjectForKey:key]){
        return nil;
    }
    if ([self smc_hasObjectForKey:key]) {
        NSString *strobj = [self smc_stringForKey:key];
        if (strobj != nil || ![strobj isEqual:[NSNull null]]) {
            NSDateFormatter *_formatter = [[NSDateFormatter alloc] init];
            [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
            NSDate *_tmpDate = [_formatter dateFromString:strobj];
            if (!_tmpDate) {
                [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                _tmpDate = [_formatter dateFromString:strobj];
            }
            return _tmpDate;
        }
    }
    return nil;
}

- (BOOL)smc_hasObjectForKey:(id)key {
    if ([self objectForKey:key]) {
        return YES;
    }
    return NO;
}

- (BOOL)smc_validate {
    return [[self allKeys] count] > 0 ? YES : NO;
}

- (BOOL)smc_validateArrayForKey:(NSString *)key {
    NSArray *array = [self objectForKey:key];
    return [array count] > 0 ? YES : NO;
}

- (BOOL)smc_validateDictionaryForKey:(NSString *)key {
    NSDictionary *dictionary = [self objectForKey:key];
    return [[dictionary allKeys] count] > 0 ? YES : NO;
}



#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
- (NSDictionary *)nullDic:(NSDictionary *)myDic{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
- (NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
- (NSString *)stringToString:(NSString *)string{
    return string;
}

//将Null类型的项目转化成@""
- (NSString *)nullToString{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
- (id)changeType{
    if ([self isKindOfClass:[NSDictionary class]]){
        return [self nullDic:self];
    }
    return nil;
}

@end
