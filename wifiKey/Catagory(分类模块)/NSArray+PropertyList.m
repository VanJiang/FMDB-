//
//  NSArray+PropertyList.m
//  TaskManage
//
//  Created by RogersHuang on 2017/4/28.
//  Copyright © 2017年 PZFinance. All rights reserved.
//

#import "NSArray+PropertyList.h"
#import <objc/runtime.h>
@implementation NSArray (PropertyList)
+ (instancetype)getPropertieArray:(Class)clas{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(clas, &count);
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    
    return mArray.copy;
}
+ (NSMutableArray *)propertieValues:(id)object customerStaticDic:(NSMutableDictionary*)customerStaticDic{
    NSMutableArray *values = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++) {
        NSMutableDictionary *objectDic = [NSMutableDictionary dictionary];
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [object valueForKey:(NSString *)propertyName];
        if (propertyValue && ![propertyName containsString:@"Id"]){
            NSDictionary *optionDic = customerStaticDic[@""[propertyValue]];
            if(optionDic){
                [objectDic setObject:optionDic[@"optionName"] forKey:@"optionName"];
                [objectDic setObject:optionDic[@"itemName"] forKey:@"itemName"];
                [values addObject:objectDic];
            }
        }
    }
    free(properties);
    return values;
}
@end
