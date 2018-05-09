//
//  GiFHUD.h
//  GiFHUD
//
//  Created by Cem Olcay on 30/10/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Singleton.h"

@interface GiFHUD : UIView
//singleton_interface(GiFHUD);
- (instancetype)initWithView:(UIView *)view;
- (void)show;
- (void)showWithOverlay;

- (void)dismiss;

- (void)setGifWithImages:(NSArray *)images;
- (void)setGifWithImageName:(NSString *)imageName;
- (void)setGifWithURL:(NSURL *)gifUrl;

@end
