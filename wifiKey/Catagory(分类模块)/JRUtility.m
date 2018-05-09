//
//  JRUtility.m
//  PoemShow
//
//  Created by 江稳 on 12-11-24.
//  Copyright (c) 2012年 江稳. All rights reserved.
//

#import "JRUtility.h"

@implementation JRUtility
+ (NSString*)getPathWithinDocumentDir:(NSString*)aPath
{
    [aPath retain];

    NSString* fullPath = nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if ([paths count] > 0) {
        fullPath = (NSString*)[paths objectAtIndex:0];
        if ([aPath length] > 0) {
            fullPath = [fullPath stringByAppendingPathComponent:aPath];
        }
    }

    [aPath release];

    return fullPath;
}
+ (NSString*)getPathWithinCaches:(NSString*)aPath
{
    [aPath retain];

    NSString* fullPath = nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    if ([paths count] > 0) {
        fullPath = (NSString*)[paths objectAtIndex:0];
        if ([aPath length] > 0) {
            fullPath = [fullPath stringByAppendingPathComponent:aPath];
        }
    }

    [aPath release];

    return fullPath;
}

+ (BOOL)createDirectory:(NSString*)dirPath lastComponentIsDirectory:(BOOL)isDir
{
    NSString* path = nil;
    if (isDir) {
        path = dirPath;
    }
    else {
        path = [dirPath stringByDeletingLastPathComponent];
    }

    if ([dirPath length] > 0 && [[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        NSError* error = nil;
        BOOL ret = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                             withIntermediateDirectories:YES
                                                              attributes:nil
                                                                   error:&error];
        if (!ret && error) {
            //	NSLog(@"create directory failed at path '%@',error:%@,%@",dirPath,[error localizedDescription],[error localizedFailureReason]);
            return NO;
        }
    }

    return YES;
}

+ (BOOL)removeFile:(NSString*)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError* error;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            //NSLog(@"remove file '%@' failed,reason:[%@]",filePath,error);
            return NO;
        }
    }
    return YES;
}

+ (NSData*)archiverObject:(NSObject*)object forKey:(NSString*)key
{
    if (object == nil) {
        return nil;
    }

    NSMutableData* data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    [archiver release];

    return [data autorelease];
}

+ (NSObject*)unarchiverObject:(NSData*)archivedData withKey:(NSString*)key
{
    if (archivedData == nil) {
        return nil;
    }

    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archivedData];
    NSObject* object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    [unarchiver release];

    return object;
}

- (void)dealloc
{
    [super dealloc];
}

@end
