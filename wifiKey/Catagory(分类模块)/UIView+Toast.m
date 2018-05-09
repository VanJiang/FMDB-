//
//  UIView+Toast.m
//  tinghao
//
//  Created by itensen003 on 14-4-21.
//  Copyright (c) 2014年 iTensen. All rights reserved.
//

#import "UIView+Toast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

// general appearance
static const CGFloat CSToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat CSToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat CSToastHorizontalPadding   = 10.0;
static const CGFloat CSToastVerticalPadding     = 10.0;
static const CGFloat CSToastCornerRadius        = 2.0;
static const CGFloat CSToastOpacity             = 0.8;
static const CGFloat CSToastFontSize            = 16.0;
static const CGFloat CSToastMaxTitleLines       = 0;
static const CGFloat CSToastMaxMessageLines     = 0;
static const NSTimeInterval CSToastFadeDuration = 0.2;

static const CGFloat CSToastAlpha               = 0.75;

// display duration and position
static const NSString * CSToastDefaultPosition  = @"center";
static const NSTimeInterval CSToastDefaultDuration  = 1.5;

// image view size
static const CGFloat CSToastImageViewWidth      = 24;
static const CGFloat CSToastImageViewHeight     = 24;

// interaction
static const BOOL CSToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * CSToastTimerKey         = @"CSToastTimerKey";

@interface UIView (ToastPrivate)

- (void)hideToast:(UIView *)toast;
- (void)toastTimerDidFinish:(NSTimer *)timer;
- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end


@implementation UIView (Toast)

#pragma mark - Toast Methods
- (void)makeNetToast:(NSString *)message{
    if (message) {
      [self makeToast:message duration:CSToastDefaultDuration position:@"center" image:[UIImage imageNamed:@"capsule_net_error.png"]];
    }
}
- (void)makeToast:(NSString *)message {
    if (message && [message length]) {
       [self makeToast:message duration:CSToastDefaultDuration position:CSToastDefaultPosition];
    }
    
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    if (message) {
        UIView *toast = [self viewForMessage:message title:nil image:nil];
        [self showToast:toast duration:duration position:position];
    }
    
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    if (message) {
        UIView *toast = [self viewForMessage:message title:title image:nil];
        [self showToast:toast duration:duration position:position];
    }
    
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    if (message) {
        UIView *toast = [self viewForMessage:message title:nil image:image];
        [self showToast:toast duration:duration position:position];
    }
    
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    if (message) {
        UIView *toast = [self viewForMessage:message title:title image:image];
        [self showToast:toast duration:duration position:position];
    }
    
}

- (void)showToast:(UIView *)toast {
    [self showToast:toast duration:CSToastDefaultDuration position:CSToastDefaultPosition];
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)point {
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    if (CSToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &CSToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
    
}

- (void)hideToast:(UIView *)toast {
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)toastTimerDidFinish:(NSTimer *)timer {
    [self hideToast:(UIView *)timer.userInfo];
}

- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &CSToastTimerKey);
    [timer invalidate];
    [self hideToast:recognizer.view];
}
#pragma mark - Helpers

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    NSLog(@"Warning: Invalid position for toast.");
    return [self centerPointForPosition:CSToastDefaultPosition withToast:toast];
}

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSToastCornerRadius;
    wrapperView.alpha  = CSToastAlpha;
    
    wrapperView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:CSToastOpacity];
    
    if(image != nil) {
        
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSToastHorizontalPadding, CSToastVerticalPadding, CSToastImageViewWidth, CSToastImageViewHeight);
        imageView.center = CGPointMake(wrapperView.center.x, imageView.center.y);
        
    }
    
    CGFloat imageWidth, imageHeight, imageLeft,imageTop;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSToastHorizontalPadding;
        imageTop = CSToastVerticalPadding;
        
    } else {
        imageWidth = imageHeight = imageLeft = imageTop = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        CGSize expectedSizeTitle = [self sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * CSToastMaxWidth), self.bounds.size.height * CSToastMaxHeight);
        CGSize expectedSizeMessage = [self sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSToastVerticalPadding;
        titleLeft = CSToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft =  CSToastHorizontalPadding;
        if (!title) {
            if (!imageView) {
                messageTop = CSToastVerticalPadding;
            }else{
                messageTop = imageHeight + CSToastVerticalPadding + imageTop;
            }
        }else{
            if (!imageView) {
                messageTop = titleTop + titleHeight +CSToastVerticalPadding;
            }else{
                messageTop = imageHeight + CSToastVerticalPadding + imageTop + titleTop + titleHeight +CSToastVerticalPadding;
            }
        }
    
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + CSToastVerticalPadding), (imageHeight + (CSToastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        titleLabel.center = CGPointMake(wrapperView.frame.size.width/2, titleTop + titleHeight/2);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        imageView.center = CGPointMake(wrapperView.frame.size.width/2, imageTop + imageHeight/2);
        [wrapperView addSubview:imageView];
    }
    return wrapperView;
}

- (void)makeToast:(NSString *)message andPostion:(PositionSite)site{
    if (site == 0) {
        [self makeToast:message duration:CSToastDefaultDuration position:@"top"];
    }else if (site == 1){
        [self makeToast:message duration:CSToastDefaultDuration position:@"center"];
    }else{
        [self makeToast:message duration:CSToastDefaultDuration position:@"bottom"];
    }
}
@end
