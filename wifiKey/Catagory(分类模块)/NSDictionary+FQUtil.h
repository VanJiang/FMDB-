//
//  NSDictionary+FQUtility.h
//  Starbucks
//
//  Created by Kim on 13-2-16.
//  Copyright (c) 2013年 FabriQate Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FQUtil)

- (id)objectForKey:(id)aKey forClass:(Class)aclass;

- (id)stringForKey:(id)aKey;
- (id)numberForKey:(id)aKey;
- (id)arrayForKey:(id)aKey;
- (id)dictionaryForKey:(id)aKey;

@end
