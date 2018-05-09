//
//  UIView+Frame.m
//  anjubao_intelligentpay_paking
//
//  Created by 陈明 on 15/7/8.
//  Copyright (c) 2015年 anjubao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.W, self.H);
}

- (CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.W, self.H);
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setW:(CGFloat)W{
    self.size = CGSizeMake(W, self.H);
}

- (CGFloat)W{
    return self.size.width;
}

- (void)setH:(CGFloat)H{
    self.size = CGSizeMake(self.W, H);
}

- (CGFloat)H{
    return self.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}
/**
 *  计算一个view相对于屏幕(去除顶部statusbar的20像素)的坐标
 *  iOS7下UIViewController.view是默认全屏的，要把这20像素考虑进去
 */
+ (CGRect)relativeFrameForScreenWithView:(UIView *)v
{
    BOOL iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7;
    CGRect screenRect=[UIScreen mainScreen].bounds;
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth=screenRect.size.width;
    if (!iOS7) {
        screenHeight -= 20;
    }
    UIView *view = v;
    CGFloat x = .0;
    CGFloat y = .0;
    while (view.frame.size.width != screenWidth || view.frame.size.height != screenHeight) {
        
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
        NSLog(@"x=%f,y=%f",x,y);

        if ([view isKindOfClass:[UIScrollView class]]) {
            x -= ((UIScrollView *) view).contentOffset.x;
            y -= ((UIScrollView *) view).contentOffset.y;
        }
        else if (view==nil)
        {
            return CGRectMake(x, y, v.frame.size.width, v.frame.size.height);

        }

    }
    return CGRectMake(x, y, v.frame.size.width, v.frame.size.height);
}

@end
