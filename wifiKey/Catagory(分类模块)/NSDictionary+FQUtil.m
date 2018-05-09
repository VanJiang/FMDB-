//
//  NSDictionary+FQUtility.m
//  Starbucks
//
//  Created by Kim on 13-2-16.
//  Copyright (c) 2013年 FabriQate Inc. All rights reserved.
//

#import "NSDictionary+FQUtil.h"

@implementation NSDictionary (FQUtil)

- (id)objectForKey:(id)aKey forClass:(Class)aclass {
    id obj = nil;
    if ([self isKindOfClass:[NSDictionary class]]) {
        obj = [self objectForKey:aKey];
        
        if ([obj isKindOfClass:aclass]) {
            goto success;
        } else {
            goto fail;
        }
    } else {
        goto fail;
    }
    
success:
    return obj;
fail:
    return nil;
}

- (id)stringForKey:(id)aKey {
    return [self objectForKey:aKey forClass:[NSString class]];
}

- (id)numberForKey:(id)aKey {
    
    if ([self objectForKey:aKey forClass:[NSNumber class]]) {
        return [self objectForKey:aKey forClass:[NSNumber class]];
    }
    
    if ([self objectForKey:aKey forClass:[NSString class]]) {
        return [NSNumber numberWithFloat:[[self objectForKey:aKey forClass:[NSString class]] floatValue]];
    }
    
    return nil;
}

- (id)arrayForKey:(id)aKey{
    return [self objectForKey:aKey forClass:[NSArray class]];
}

- (id)dictionaryForKey:(id)aKey {
    return [self objectForKey:aKey forClass:[NSDictionary class]];
}

@end
