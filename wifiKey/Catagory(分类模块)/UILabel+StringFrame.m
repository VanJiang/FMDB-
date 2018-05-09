//
//  UILabel+StringFrame.m
//  Demo
//
//  Created by rogers on 15/11/6.
//  Copyright © 2015年 格式化油条. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
