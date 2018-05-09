//
//  UILabel+border.m
//  XXPresentDemo
//
//  Created by Louis on 16/3/17.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "UILabel+border.h"

@implementation UILabel_border

- (void)drawTextInRect:(CGRect)rect {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [super drawTextInRect:rect];
        self.textColor = self.fillColor;
        CGContextSetTextDrawingMode(c, kCGTextFill);
        [super drawTextInRect:rect];
}

@end
