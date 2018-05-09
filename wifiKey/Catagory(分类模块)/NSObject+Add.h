//
//  NSObject+Add.h
//  掌上公交
//
//  Created by xvhongbin on 14-6-16.
//  Copyright (c) 2014年 gps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Add)
- (NSArray*)propertyKeys;
- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource;

@end
