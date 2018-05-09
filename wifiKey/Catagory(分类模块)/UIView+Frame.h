//
//  UIView+Frame.h
//  anjubao_intelligentpay_paking
//
//  Created by 陈明 on 15/7/8.
//  Copyright (c) 2015年 anjubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
/**
 *  控件的x值
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  控件的y值
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  控件的width值
 */
@property (nonatomic, assign) CGFloat W;
/**
 *  控件的height值
 */
@property (nonatomic, assign) CGFloat H;
/**
 *  控件的大小值
 */
@property (nonatomic, assign) CGSize size;
+ (CGRect)relativeFrameForScreenWithView:(UIView *)v;

@end
