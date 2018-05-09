//
//  UIView+Option.m
//  TaskManage
//
//  Created by RogersHuang on 2017/4/25.
//  Copyright © 2017年 PZFinance. All rights reserved.
//

#import "UIView+Option.h"
#import <objc/runtime.h>
static const void *ViewOptionKey = &ViewOptionKey;
static const void *ViewStringTagKey = &ViewStringTagKey;
@implementation UIView (Option)
@dynamic viewOption,stringTag;
-(void)setViewOption:(NSMutableDictionary *)viewOption{
    objc_setAssociatedObject(self, ViewOptionKey, viewOption, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableDictionary*)getViewOption{
    return objc_getAssociatedObject(self, ViewOptionKey);
}

-(void)setStringTag:(NSString *)stringTag{
    objc_setAssociatedObject(self, ViewStringTagKey, stringTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString*)getStringTag{
    return objc_getAssociatedObject(self, ViewStringTagKey);
}
@end
