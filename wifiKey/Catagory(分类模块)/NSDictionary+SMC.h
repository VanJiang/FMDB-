//
//  NSDictionary+SMC.h
//  SMCKit
//
//  Created by Ren JianSheng on 11-11-8.
//  Copyright (c) 2011年 3gtv.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SMC)

+(NSDictionary*)initFromJSONObject:(NSString *)json;

- (NSString *)smc_stringForKey:(id)key;
- (NSInteger)smc_intForKey:(id)key;
- (CGFloat)smc_floatForKey:(id)key;
- (BOOL)smc_boolForKey:(id)key;
- (long)smc_longForKey:(id)key;
-(NSDate*)smc_dateForKey:(id)key;

- (BOOL)smc_hasObjectForKey:(id)key;
- (id)smc_ObjectForKey:(id)key;
- (BOOL)smc_validate;
- (BOOL)smc_validateArrayForKey:(id)key;
- (BOOL)smc_validateDictionaryForKey:(id)key;
- (id)changeType;
@end
