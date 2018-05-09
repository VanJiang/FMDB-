//
//  UIColor+Hex.m
//  transitSystem
//
//  Created by xvhongbin on 14-7-28.
//  Copyright (c) 2014年 xvhongbin. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor*) colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
//+(CAGradientLayer *)shadowAsInverse:(CGRect)frame andFirstColor:(UIColor *)firstColor andNextColor:(UIColor *)nextColor
//{
//    CAGradientLayer *newShadow = [[[CAGradientLayer alloc] init] autorelease];
//    //    CGRect newShadowFrame = CGRectMake(0, 0, 320, self.frame.size.height);
//    newShadow.frame = frame;
//    //添加渐变的颜色组合
//    newShadow.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor,(id)nextColor.CGColor,nil];
//    return newShadow;
//}
+(UIImage *)ImageFormColors:(NSArray *)colors andFrame:(CGRect)frame ByGradientType:(GradientType)gradientType
{
    NSMutableArray * ar=[NSMutableArray array];
    for (UIColor * color in colors) {
        [ar addObject:(id)color.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace=CGColorGetColorSpace([[colors lastObject] CGColor] );
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, frame.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(frame.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(frame.size.width, frame.size.height);
            break;
        case 3:
            start = CGPointMake(frame.size.width, 0.0);
            end = CGPointMake(0.0,frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;

}
// 颜色转换 IOS中十六进制的颜色转换为UIColor
+(UIColor *) colorWithHexString: (NSString *)color
{

    
    return [self colorWithHexString:color alpha:1.0f];
}
+(UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 判断字符的长度是
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 如果带有0x
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 分离成R G B
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // 获取值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
