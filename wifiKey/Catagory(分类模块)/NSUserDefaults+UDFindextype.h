//
//  NSUserDefaults+UDFindextype.h
//  ZhongdaBoyan
//
//  Created by JIMU on 15/4/9.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (UDFindextype)
- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
@end
