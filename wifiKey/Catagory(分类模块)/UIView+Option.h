//
//  UIView+Option.h
//  TaskManage
//
//  Created by RogersHuang on 2017/4/25.
//  Copyright © 2017年 PZFinance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Option)
@property(retain,nonatomic)NSMutableDictionary*viewOption;
- (void)setViewOption:(NSMutableDictionary *)viewOption;
- (NSMutableDictionary*)getViewOption;

@property(retain,nonatomic)NSString*stringTag;
- (void)setStringTag:(NSString *)stringTag;
- (NSString*)getStringTag;
@end
