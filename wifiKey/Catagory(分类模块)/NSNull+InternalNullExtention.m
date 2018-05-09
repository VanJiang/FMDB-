//
//  NSNull+InternalNullExtention.m
//  RRXCStudent
//
//  Created by RogersHuang on 16/9/21.
//  Copyright © 2016年 SMTech. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"


@implementation NSNull (InternalNullExtention)
- (void)forwardInvocation:(NSInvocation *)invocation

{
    
    if ([self respondsToSelector:[invocation selector]]) {
        
        [invocation invokeWithTarget:self];
        
    }
    
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector

{
    
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    
    if(sig == nil) {
        
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
        
    }
    
    return sig;
    
}
@end
