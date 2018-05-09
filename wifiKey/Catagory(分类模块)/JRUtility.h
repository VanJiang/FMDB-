//
//  JRUtility.h
//  PoemShow
//
//  Created by 江稳 on 12-11-24.
//  Copyright (c) 2012年 江稳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRUtility : NSObject

+ (NSString*)getPathWithinDocumentDir:(NSString*)aPath;
+ (NSString*)getPathWithinCaches:(NSString*)aPath;
+ (BOOL)createDirectory:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir;
+ (BOOL)removeFile:(NSString*)filePath;

+ (NSData*)archiverObject:(NSObject*)object forKey:(NSString*)key;
+ (NSObject*)unarchiverObject:(NSData*)archivedData withKey:(NSString*)key;

@end
