//
//  NSString+URL.h
//  Quanner
//
//  Created by Rogers Huang on 15/12/15.
//  Copyright © 2015年 juexin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)URLEncodedString;
- (NSString*)gtm_stringByEscapingForURLArgument;

@end
