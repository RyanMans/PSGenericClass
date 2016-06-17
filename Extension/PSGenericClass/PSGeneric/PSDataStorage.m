//
//  PSDataStorage.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//


#import "PSDataStorage.h"
#include <sqlite3.h>
#define NewMutableString() [NSMutableString stringWithCapacity:128]

#define SQLExecuteUpdate(x, y) [x sc_executeUpdateWithSQL:y params:nil block:nil]
@interface FMResultSet ()
@end

@implementation FMResultSet (Ryan_Man)

- (NSMutableDictionary *)columnNameToIndexKey
{
    int columnCount = sqlite3_column_count([_statement statement]);
    NSMutableDictionary * temp = [[NSMutableDictionary alloc] initWithCapacity:(NSUInteger)columnCount];
    int columnIdx = 0;
    for (columnIdx = 0; columnIdx < columnCount; columnIdx++)
    {
        NSString * value = [NSString stringWithUTF8String:sqlite3_column_name([_statement statement], columnIdx)];
        NSString * key = value.lowercaseString;
        
        [temp setObject:value forKey:key];
    }
    
    return temp;
}

- (NSMutableDictionary *)toDictionary
{
    NSMutableDictionary *temp = [NSMutableDictionary new];
    NSDictionary *buffer = [self columnNameToIndexMap];
    NSDictionary * aaa = [self columnNameToIndexKey];

    for (NSString *key in buffer.allKeys)
    {
        id obj = [self objectForColumnName:key];
        [temp setObject:obj forKey:aaa[key]];
    }
    return temp;
}

@end

@interface PSDataStorage  ()
{
    BOOL Ryan_Man;
    
    dispatch_queue_t _dbQueue;
}
@end
@implementation PSDataStorage
- (instancetype)init
{
    self = [super init];
    if (self) {
        Ryan_Man = NO;
        _dbQueue = dispatch_queue_create("isRun.thread.com", 0);
        dispatch_queue_set_specific(_dbQueue, &Ryan_Man, &Ryan_Man, NULL);
    }
    return self;
}

- (BOOL)isMainThread
{
    void *value = dispatch_get_specific(&Ryan_Man);
    return (value == &Ryan_Man);
}

//更新
- (BOOL)executeUpdateWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseUpdateBlock)block
{
    if ([self isMainThread]) return [self sc_executeUpdateWithSQL:sql params:params block:block];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_executeUpdateWithSQL:sql params:params block:block];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_executeUpdateWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseUpdateBlock)block
{
    BOOL temp = [_fmdb executeUpdate:sql withArgumentsInArray:params];
    if (temp)
    {
        if (block) block(_fmdb, YES);
        return YES;
    }
    
    if (block) block(_fmdb, NO);
    
    return NO;
}
//查找
- (void)executeQueryWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseQueryBlock)block
{
    if ([self isMainThread]) return [self sc_executeQueryWithSQL:sql params:params block:block];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    dispatch_async(_dbQueue, ^{
        [self sc_executeQueryWithSQL:sql params:params block:block];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
}

- (void)sc_executeQueryWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseQueryBlock)block
{
    FMResultSet *rs = [_fmdb executeQuery:sql withArgumentsInArray:params];
    if (block) block(_fmdb, rs);
    [rs close];
}

//打开数据库
- (BOOL)openDataBase:(NSString *)path
{
    if ([self isMainThread])return [self sc_openDataBase:path];
    
    while (Ryan_Man) MinSleep();
    
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        
        state = [self sc_openDataBase:path];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_openDataBase: (NSString *)path
{
    FMDatabase *temp = [FMDatabase databaseWithPath:path];
    if (NO == [temp open]) return NO;
    _fmdb = temp;
    _dataBaseFilePath = path;
    return YES;
}

//关闭数据库
- (BOOL)closeDataBase
{
    if ([self isMainThread]) return [self sc_closeDataBase];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_closeDataBase];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_closeDataBase
{
    if (NO == [_fmdb close]) return NO;
    _dataBaseFilePath = nil;
    _fmdb = nil;
    return YES;
}

//判断表是否存在
- (BOOL)isExistsDataTable: (NSString *)table
{
    if ([self isMainThread]) return [self sc_isExistsDataTable:table];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        
        state = [self sc_isExistsDataTable:table];
        Ryan_Man = NO;
    });
    
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_isExistsDataTable: (NSString *)table
{
    NSString *temp = [NSString stringWithFormat:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='%@' LIMIT 1", table];
    __block BOOL state = NO;
    [self sc_executeQueryWithSQL:temp params:nil block:^(FMDatabase *database, FMResultSet *rs) {
        if (NO == [rs next]) return ;
        state = [rs boolForColumnIndex:0];
    }];
    return state;
}

//创建表
- (BOOL)createDataTable:(NSString *)sqlString;
{
    if ([self isMainThread]) return [self sc_createDataTable:sqlString];

    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    
    dispatch_async(_dbQueue, ^{
        
        state = [self sc_createDataTable:sqlString];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
    
}

- (BOOL)sc_createDataTable: (NSString *)sqlString
{
    [self executeQueryWithSQL:sqlString params:nil block:nil];
    return  YES;
}

//根据字典创建表
- (BOOL)createDataTable: (NSString *)table fromDemoData: (NSDictionary *)data;
{
    if ([self isMainThread]) return [self sc_createDataTable:table fromDemoData:data];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    
    dispatch_async(_dbQueue, ^{
        
        state = [self sc_createDataTable:table fromDemoData:data];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_createDataTable: (NSString *)table fromDemoData: (NSDictionary *)data
{
    NSDictionary *temp = dictionaryToDBColumnNameAndTypes(data);
    return [self sc_createDataTable:table fromTypeList:temp];
}

- (BOOL)sc_createDataTable: (NSString *)table fromTypeList: (NSDictionary *)data
{
    NSArray *keys = data.allKeys;
    NSString *key = keys[0];
    NSMutableString *buffer = NewMutableString();
    [buffer appendFormat:@"\"%@\" %@", key, data[key]];
    
    for (long a = 1; a < keys.count; ++a)
    {
        key = keys[a];
        [buffer appendFormat:@", \"%@\" %@", key, data[key]];
    }
    
    return [self sc_createDataTable:table columnName:buffer, nil];
}

- (BOOL)sc_createDataTable: (NSString *)table columnName: (NSString *)name, ...
{
    NSMutableString *temp = NewMutableString();
    [temp appendFormat:@"create table '%@' (%@", table, name];
    va_list ap;
    va_start(ap, name);
    name = va_arg(ap, NSString *);
    while (name)
    {
        [temp appendFormat:@", %@", name];
        name = va_arg(ap, NSString *);
    }
    va_end(ap);
    [temp appendString:@")"];
    
    return  SQLExecuteUpdate(self, temp);
}

//判断表中是否存在某条数据
- (BOOL)existsRowWithTable:(NSString *)table indexName:(NSString *)indexName indexData:(id)indexData
{
    
    NSString *temp = [NSString stringWithFormat:@"SELECT count(*) FROM '%@' WHERE \"%@\" = ? LIMIT 1", table, indexName];
    __block BOOL state = NO;
    [self executeQueryWithSQL:temp params:@[indexData] block:^(FMDatabase *database, FMResultSet *rs) {
        if (NO == [rs next]) return ;
        state = [rs longForColumnIndex:0];
    }];
    return state;
}

//插入表
- (BOOL)insertDataWithTable: (NSString *)table columnData: (NSDictionary *)data
{
    if ([self isMainThread]) return [self sc_insertDataWithTable:table columnData:data];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_insertDataWithTable:table columnData:data];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_insertDataWithTable: (NSString *)table columnData: (NSDictionary *)data
{
    if (0 == data.count) return NO;
    
    NSArray *keys = data.allKeys;
    NSMutableArray *datas = NewMutableArray();
    
    NSMutableString *names = NewMutableString();
    [names appendFormat:@"'%@'", keys[0]];
    NSMutableString *values = NewMutableString();
    [values appendString: @"?"];
    
    for (long a = 1; a < keys.count; ++a)
    {
        NSString *key = keys[a];
        [names appendFormat:@", '%@'", key];
        [values appendString:@", ?"];
    }
    
    NSString *temp = [NSString stringWithFormat:@"insert into '%@' (%@) values(%@)", table, names, values];
    
    for (long a = 0; a < keys.count; ++a)
    {
        NSString *key = keys[a];
        [datas addObject:data[key]];
    }
    
    return [self sc_executeUpdateWithSQL:temp params:datas block:nil];
}

//更新表
- (BOOL)updateDataWithTable:(NSString *)table indexName:(NSString *)indexName indexData:(id)indexData columnData:(NSDictionary *)data
{
    if ([self isMainThread]) return [self sc_updateDataWithTable:table indexName:indexName indexData:indexData columnData:data];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_updateDataWithTable:table indexName:indexName indexData:indexData columnData:data];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_updateDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData columnData: (NSDictionary *)data
{
    NSArray *keys = data.allKeys;
    NSMutableArray *datas = NewMutableArray();
    
    NSString *key = keys[0];
    NSMutableString *temp = NewMutableString();
    [temp appendFormat:@"UPDATE '%@' SET '%@' = ?", table, key];
    
    for (long a = 1; a < keys.count; ++a)
    {
        key = keys[a];
        [temp appendFormat:@", '%@' = ?", key];
    }
    
    [temp appendFormat:@" WHERE \"%@\" = ?", iName];
    
    for (long a = 0; a < keys.count; ++a)
    {
        key = keys[a];
        [datas addObject:data[key]];
    }
    [datas addObject:iData];
    
    return [self sc_executeUpdateWithSQL:temp params:datas block:nil];
}
//更新表中数据，如不存在则插入
- (BOOL)autoUpdateWithTable:(NSString *)table columnData:(NSDictionary *)data indexName:(NSString *)indexName indexData:(id)indexData
{
    
    if (nil == indexData) return NO;
    
    if ([self isMainThread]) return [self sc_autoUpdateWithTable:table columnData:data indexName:indexName indexData:indexData];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_autoUpdateWithTable:table columnData:data indexName:indexName indexData:indexData];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
    
}

- (BOOL)sc_autoUpdateWithTable: (NSString *)table columnData: (NSDictionary *)data indexName: (NSString *)name indexData: (id)iData
{
    if (nil == iData) iData = data[name];
    
    if ([self existsRowWithTable:table indexName:name indexData:iData])
    {
        return [self updateDataWithTable:table indexName:name indexData:iData columnData:data];
    }
    
    return [self insertDataWithTable:table columnData:data];
}

//清空表
- (BOOL)clearDataTable: (NSString *)table
{
    if ([self isMainThread]) return [self sc_clearDataTable:table];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_clearDataTable:table];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_clearDataTable: (NSString *)table
{
    NSString *temp = [NSString stringWithFormat:@"delete from '%@'", table];
    return SQLExecuteUpdate(self, temp);
}

//删除表数据
- (BOOL)deleteDataWithTable:(NSString *)table indexName:(NSString *)indexName indexData:(id)indexData
{
    if (nil == indexData) return NO;
    
    if ([self isMainThread]) return [self sc_deleteDataWithTable:table indexName:indexName indexData:indexData];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block BOOL state = NO;
    dispatch_async(_dbQueue, ^{
        state = [self sc_deleteDataWithTable:table indexName:indexName indexData:indexData];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (BOOL)sc_deleteDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData
{
    NSString *buffer = [NSString stringWithFormat:@"delete from '%@' where \"%@\" = ?", table, iName];
    return [self sc_executeUpdateWithSQL:buffer params:@[iData] block:nil];
}

//获取表中某条数据
- (NSDictionary *)queryDataWithTable:(NSString *)table indexName:(NSString *)indexName indexData:(id)indexData
{
    if (nil == indexData) return nil;
    
    if ([self isMainThread]) return [self sc_queryDataWithTable:table indexName:indexName indexData:indexData];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block NSDictionary *state = nil;
    dispatch_async(_dbQueue, ^{
        state = [self sc_queryDataWithTable:table indexName:indexName indexData:indexData];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (NSMutableDictionary *)sc_queryDataWithTable: (NSString *)table indexName: (NSString *)iName indexData: (id)iData
{
    NSString *buffer = [NSString stringWithFormat:@"select * from '%@' where \"%@\" = ? LIMIT 1", table, iName];
    
    __block NSMutableDictionary *temp = nil;
    [self sc_executeQueryWithSQL:buffer params:@[iData] block:^(FMDatabase *database, FMResultSet *rs) {
        if (NO == [rs next]) return ;
        
        temp = [rs toDictionary];
    }];
    return temp;
}


//获取表中全部数据
- (NSArray *)getAllDataFromTable:(NSString *)table
{
    if ([self isMainThread]) return [self sc_getAllDataFromTable:table];
    
    while (Ryan_Man) MinSleep();
    Ryan_Man = YES;
    __block NSArray *state = nil;
    dispatch_async(_dbQueue, ^{
        state = [self sc_getAllDataFromTable:table];
        Ryan_Man = NO;
    });
    while (Ryan_Man) MinSleep();
    return state;
}

- (NSMutableArray *)sc_getAllDataFromTable:(NSString *)table
{
    NSString *sql = [NSString stringWithFormat:@"select * from '%@'", table];
    
    __block NSMutableArray *result = nil;
    [self sc_executeQueryWithSQL:sql params:nil block:^(FMDatabase *database, FMResultSet *rs) {
        if (NO == [rs next]) return;
        
        result = NewMutableArray();
        do
        {
            NSDictionary *temp = [rs toDictionary];
            [result addObject:temp];
        }while ([rs next]);
        
    }];
    
    return result;
}

NSDictionary *dictionaryToDBColumnNameAndTypes(NSDictionary *source)
{
    if (source == nil || source.count == 0 )return @{};
    
    NSMutableDictionary * temp = [source mutableCopy];
    
    for (NSString * key in temp.allKeys)
    {
        id value = temp [key];
        
        if (IsKindOfClass(value, NSString)) {
            temp[key] = @"text DEFAULT ('')";
        }
        else if (IsKindOfClass(value, NSNumber))
        {
            temp[key] = @"numeric DEFAULT (0)";
        }
    }
    return temp;
    
}



@end
