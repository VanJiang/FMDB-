//
//  NSObject+Add.m
//  掌上公交
//
//  Created by xvhongbin on 14-6-16.
//  Copyright (c) 2014年 gps. All rights reserved.
//

#import "NSObject+Add.h"
#import <objc/runtime.h>
@implementation NSObject (Add)
- (NSArray*)propertyKeys

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
//        [propertyName release];
        
    }
    
    free(properties);
    
    return keys;
    
}
-(NSDictionary *)stringToJSON:(id)theObject
{
//    NSString *className = NSStringFromClass([theObject class]);
//    
//    const char *cClassName = [className UTF8String];
//    
//    id theClass = objc_getClass(cClassName);
//    
//    unsigned int outCount, i;
//    
//    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
//    
//    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:1];
//    
//    for (i = 0; i < outCount; i++) {
//        
//        objc_property_t property = properties[i];
//        
//        NSString *propertyNameString = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        
//        [propertyNames addObject:propertyNameString];
//        
//        
//        NSLog(@"%s %s\n", property_getName(property), property_getAttributes(property));
//        
//    }
    
    NSMutableDictionary *finalDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    for(NSString *key in [self propertyKeys])
    {
        SEL selector = NSSelectorFromString(key);
        id value = [theObject performSelector:selector];
        
        if (value == nil)
        {
            value = [NSNull null];
        }
        
        [finalDict setObject:value forKey:key];
    }
    
    
//    NSString *retString = [finalDict JSONString];
//    [finalDict release];
    
    return finalDict;
}

- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource

{
    
    BOOL ret = NO;
    
    for (NSString *key in [self propertyKeys]) {
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
            
        }
        
        else
            
        {
            
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
            
        }
        
        if (ret) {
            
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:key];
            
            }           
            
        }
        
    }
    
    return ret;
    
}
@end
