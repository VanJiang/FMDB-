//
//  ShowMessage.m
//  anjubao_intelligentpay_paking
//
//  Created by 李树文 on 15/7/9.
//  Copyright (c) 2015年 anjubao. All rights reserved.
//

#import "ShowMessage.h"

@interface ShowMessage ()
@property (nonatomic, weak) UIView* showView;
@property (nonatomic, weak) UILabel* msgLabel;
@end

@implementation ShowMessage
static id _instance = nil;

- (UIView*)showView
{
    if (_showView == nil) {
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        UIView* showView = [[UIView alloc] init];
        showView.backgroundColor = [UIColor blackColor];
        showView.frame = CGRectMake(1, 1, 1, 1);
        showView.alpha = 1.0f;
        showView.layer.cornerRadius = 5.0f;
        showView.layer.masksToBounds = YES;
        [window addSubview:showView];
        
        [window bringSubviewToFront:showView];
        UILabel* label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];

        [showView addSubview:label];
        _showView = showView;
        self.msgLabel = label;
    }
    return _showView;
}

+ (void)showMessage:(NSString*)message
{
    [[self shared] showMessage:message];
}

- (void)showMessage:(NSString*)message
{
    [self showView];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    CGSize maxSize = CGSizeMake(UIScreenW - 30, CGFLOAT_MAX);
    UIFont* font = [UIFont systemFontOfSize:17];

    CGSize labelSize = [message boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil]
                           .size;

    self.msgLabel.frame = CGRectMake(10, 5, labelSize.width, labelSize.height);
    self.msgLabel.text = message;
    self.showView.frame = CGRectMake((UIScreenW - labelSize.width - 20) * 0.5, UIScreenH - 80, labelSize.width + 20, labelSize.height + 10);
    self.showView.alpha = 1.0f;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0f animations:^{
            self.showView.alpha = 0;
        }
            completion:^(BOOL finished){
                      [self.showView removeFromSuperview];
                       self.showView = nil;
                [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
            }];

   // });
}

+ (instancetype)shared
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
    if (_instance == nil) {
        _instance = [[self alloc]init];
    }
    
    //    NSLog(@"showMessage: %p",_instance);
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone*)zone
{
    if (_instance == nil) {
       _instance = [super allocWithZone:zone];
    }
    
    //    NSLog(@"showMessage: %p",_instance);
    return _instance;

//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//    });
//    return _instance;
}

@end
