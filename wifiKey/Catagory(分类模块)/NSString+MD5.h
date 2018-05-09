//
//  NSString+MD5.h
//  YueMao
//
//  Created by cndw on 16/5/20.
//
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  md5加密的字符串
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *) md5:(NSString *) str;
+ (NSString *) md5HexDigest:(NSString *) str;
@end

