//
//  BaseViewController.h
//  CheKu
//
//  Created by JIMU on 15/3/27.
//  Copyright (c) 2015年 puxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ViewControllerJumpType) {
    ViewControllerJumpTypePush,
    ViewControllerJumpTypePresent
};
@interface BaseViewController : UIViewController
@property (assign, nonatomic) ViewControllerJumpType type;
//- (UIImage*)createImageWithColor:(UIColor*)color;
- (void)backButtonAction;
@end
