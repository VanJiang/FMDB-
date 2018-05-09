//
//  WiFiListDB.h
//  wifiKey
//
//  Created by 寒山 on 2018/1/26.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "WiFiInfoModel.h"
#import "JRUtility.h"
@interface WiFiListDB : NSObject
{
    FMDatabase* _db;
}
- (BOOL)createContentTable;
- (BOOL)addContent:(WiFiInfoModel*)brandInfo;
- (NSMutableArray*)getAllContent;
- (void)deleteAllContent;
@end
