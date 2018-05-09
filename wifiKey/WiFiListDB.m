//
//  WiFiListDB.m
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "WiFiListDB.h"
@implementation WiFiListDB
- (id)init
{
    self = [super init];
    if (self) {
        NSString* dbPath = [JRUtility getPathWithinDocumentDir:CONTENTDBNAME];
        // NSLog(@"%@",dbPath);
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //判断文件是否存在
        BOOL existFile = [fileManager fileExistsAtPath:dbPath];
        if (existFile == NO) {
            NSString* poemDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:CONTENTDBNAME];
            [fileManager copyItemAtPath:poemDBPath toPath:dbPath error:nil];
        }
        _db = [[FMDatabase alloc] initWithPath:dbPath];
        if ([_db open] == NO) {
            return nil;
        }
    }
    return self;
}
//建立数据库表
- (BOOL)createContentTable
{
    [_db beginTransaction];
    
    BOOL success = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS CONTENTTABLE (wifiName TEXT ,wifiPassword TEXT,creatTime TEXT);"];
    [_db commit];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        
        NSLog(@"faild");
        return NO;
    }
    else {
        NSLog(@"success12");
    }
    return YES;
}
//增加数据
-(BOOL)addContent:(WiFiInfoModel*)brandInfo
{
    [_db beginTransaction];
    
    BOOL success = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
                    [NSString stringWithFormat:@"%@",brandInfo.wifiName],
                    brandInfo.wifiPassword,
                    brandInfo.creatTime];
    
    [_db commit];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    return YES;
}
//批处理数据 仅作示例
- (void)batchAddContent:(WiFiInfoModel*)brandInfo{
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<100000; i++) {
            
            BOOL success = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
                            [NSString stringWithFormat:@"%@",brandInfo.wifiName],
                            brandInfo.wifiPassword,
                            brandInfo.creatTime];
            if (!success ) {
                NSLog(@"插入失败1");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        [_db rollback];
    }
    @finally {
        if (!isRollBack) {
            [_db commit];
        }
    }
 }
//搜索内容
- (NSMutableArray*)serachContent:(NSString*)searchText
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM CONTENTTABLE WHERE wifiName LIKE '%@%%'", searchText];
    
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        WiFiInfoModel* brandInfo = [[WiFiInfoModel alloc] init];
        brandInfo.wifiName= [rs stringForColumn:@"wifiName"];
        brandInfo.wifiPassword= [rs stringForColumn:@"wifiPassword"];
        brandInfo.creatTime= [rs stringForColumn:@"creatTime"];
        [result addObject:brandInfo ];
    }
    [rs close];
    NSMutableArray* sort = [NSMutableArray array];
    if (result && [result count] > 0) {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creatTime" ascending:NO] ;
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sort = [NSMutableArray arrayWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
    }
    
    return sort;
}
//更新数据
- (BOOL)updateContent:(NSString*)searchText withUpdateStr:(NSString *)updateStr
{
    
    [_db beginTransaction];
     NSString *sqlStr=[NSString stringWithFormat:@"UPDATE CONTENTTABLE SET wifiName='%@' WHERE wifiName LIKE '%@'", updateStr,searchText];
    BOOL success = [_db executeUpdate:sqlStr];
    
    [_db commit];
    
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"faild  yes  no");
        return NO;
    }
    return YES;
}
//获取所有数据
- (NSMutableArray*)getAllContent
{
    NSMutableArray* result = [NSMutableArray array];
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT  *  FROM CONTENTTABLE"];
    
    FMResultSet* rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        WiFiInfoModel* brandInfo = [[WiFiInfoModel alloc] init];
        brandInfo.wifiName= [rs stringForColumn:@"wifiName"];
        brandInfo.wifiPassword= [rs stringForColumn:@"wifiPassword"];
        brandInfo.creatTime= [rs stringForColumn:@"creatTime"];
        [result addObject:brandInfo ];
    }
    [rs close];
    NSMutableArray* sort = [NSMutableArray array];
    if (result && [result count] > 0) {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creatTime" ascending:NO] ;
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sort = [NSMutableArray arrayWithArray:[result sortedArrayUsingDescriptors:sortDescriptors]];
    }
    
    return sort;
}
//删除单条内容
- (void)deleteContent:(NSString *)searchText
{
    [_db beginTransaction];
    BOOL success = [_db executeUpdate:@"DELETE FROM CONTENTTABLE WHERE wifiName = '%@%%'", searchText];
    [_db commit];
    if(!success ||[_db hadError])
    {
        [_db rollback];
        NSLog(@"error1");
    }
}
//删除所有数据
- (void)deleteAllContent
{
    [_db beginTransaction];
    BOOL success = [_db executeUpdate:@"DELETE  FROM CONTENTTABLE"];
    [_db commit];
    if (!success || [_db hadError]) {
        [_db rollback];
        NSLog(@"error1");
        //return NO;
    }
}
//FMDatabaseQueue仅作示例
- (void)explamFMDatabaseQueue:(WiFiInfoModel*)brandInfo{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:nil];
    
    [queue inDatabase:^(FMDatabase *db) {//从这个block中直接获得打开的数据库实例
        
        BOOL success = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
                        [NSString stringWithFormat:@"%@",brandInfo.wifiName],
                        brandInfo.wifiPassword,
                        brandInfo.creatTime];
        BOOL success2 = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
                        [NSString stringWithFormat:@"%@",brandInfo.wifiName],
                        brandInfo.wifiPassword,
                        brandInfo.creatTime];
        BOOL success3 = [_db executeUpdate:@"INSERT INTO CONTENTTABLE( wifiName,wifiPassword,creatTime) VALUES (?,?,?)",
                        [NSString stringWithFormat:@"%@",brandInfo.wifiName],
                        brandInfo.wifiPassword,
                        brandInfo.creatTime];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_student"];
        while ([rs next]) {
            // …
        }
    }];
}
@end
