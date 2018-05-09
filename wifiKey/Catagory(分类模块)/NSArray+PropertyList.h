//
//  NSArray+PropertyList.h
//  TaskManage
//
//  Created by RogersHuang on 2017/4/28.
//  Copyright © 2017年 PZFinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PropertyList)
+ (instancetype)getPropertieArray:(Class)clas;
+ (NSMutableArray *)propertieValues:(id)object customerStaticDic:(NSMutableDictionary*)customerStaticDic;
@end
