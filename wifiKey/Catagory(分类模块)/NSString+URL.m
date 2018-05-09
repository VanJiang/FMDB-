//
//  NSString+URL.m
//  Quanner
//
//  Created by Rogers Huang on 15/12/15.
//  Copyright © 2015年 juexin. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString*)gtm_stringByEscapingForURLArgument {
    // Encode all the reserved characters, per RFC 3986
    // (<</span>http://www.ietf.org/rfc/rfc3986.txt>)
    CFStringRef escaped =
    CFURLCreateStringByAddingPercentEscapes
    (kCFAllocatorDefault,
     (CFStringRef)self,
     NULL,
     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
     kCFStringEncodingUTF8);
    return CFAutorelease(escaped);
}

- (NSString*)gtm_stringByUnescapingFromURLArgument {
    NSMutableString *resultString =
    [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return
    [resultString
     stringByReplacingPercentEscapesUsingEncoding:
     NSUTF8StringEncoding];  
}
@end
