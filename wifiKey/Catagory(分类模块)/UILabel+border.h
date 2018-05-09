//
//  UILabel+border.h
//  XXPresentDemo
//
//  Created by Louis on 16/3/17.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel_border : UILabel

//+ (instancetype)labelWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor strokeWidth:(CGFloat)strokeWidth;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, assign) CGFloat strokeWidth;

@end
