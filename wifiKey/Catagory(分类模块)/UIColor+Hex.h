//
//  UIColor+Hex.h
//  transitSystem
//
//  Created by xvhongbin on 14-7-28.
//  Copyright (c) 2014年 xvhongbin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {
    topToBottom = 0,//从上到下
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;
@interface UIColor (Hex)
+ (UIColor*) colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
//+(CAGradientLayer *)shadowAsInverse:(CGRect)frame andFirstColor:(UIColor *)firstColor andNextColor:(UIColor *)nextColor;
+(UIColor *) colorWithHexString: (NSString *)color;
+(UIImage *)ImageFormColors:(NSArray *)colors andFrame:(CGRect)frame ByGradientType:(GradientType)gradientType;
+(UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha;

@end
