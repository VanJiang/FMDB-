//
//  UIView+Toast.h
//  tinghao
//
//  Created by itensen003 on 14-4-21.
//  Copyright (c) 2014年 iTensen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    PositionTop = 0,
    PositionCenter,
    PositionBottom,
}PositionSite;

@interface UIView (Toast)

// each makeToast method creates a view and displays it as toast

- (void)makeToast:(NSString *)message;
- (void)makeNetToast:(NSString *)message;
- (void)makeToast:(NSString *)message andPostion:(PositionSite)site;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

// the showToast methods display any view as toast

- (void)showToast:(UIView *)toast;

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;



@end
