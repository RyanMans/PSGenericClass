//
//  PSDataStorage.h
//  EJY
//
//  Created by Ryan_Man on 16/4/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

/**
 *  数据库工具类
 *
 */

@class FMDatabase;
@class FMResultSet;
typedef void(^DataBaseUpdateBlock)(FMDatabase *database, BOOL state);
typedef void(^DataBaseQueryBlock)(FMDatabase *database, FMResultSet *rs);

@interface PSDataStorage : NSObject
@property (nonatomic, strong,readonly)FMDatabase * fmdb;
@property (nonatomic, strong, readonly) NSString *dataBaseFilePath;

// @[sql, arg1, arg2, arg3, ...]
/** 查找 **/
- (void)executeQueryWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseQueryBlock)block;
/** 更新 **/
- (BOOL)executeUpdateWithSQL: (NSString *)sql params: (NSArray *)params block: (DataBaseUpdateBlock)block;


/**
 *   打开数据库
 *
 *  @param path
 *
 *  @return
 */
- (BOOL)openDataBase: (NSString *)path;

/**
 *  关闭数据库
 *
 *  @return
 */
- (BOOL)closeDataBase;

/**
 *   判断表是否存在
 *
 *  @param table
 *
 *  @return
 */
- (BOOL)isExistsDataTable: (NSString *)table;


/**
 *  创建表
 *
 *  @param table
 *  @param sqlString
 *
 *  @return
 */
- (BOOL)createDataTable:(NSString *)sqlString;

/**
 *  根据一个字典 创建表
 *
 *  @param table
 *  @param data  不可为空
 *
 *  @return
 */
- (BOOL)createDataTable: (NSString *)table fromDemoData: (NSDictionary *)data;

/**
 *  判断表中 是否存在某条数据
 *
 *  @param table
 *  @param name
 *  @param data
 *
 *  @return
 */
- (BOOL)existsRowWithTable: (NSString *)table indexName: (NSString *)indexName indexData: (id)indexData;

/**
 *  插入表数据
 *
 *  @param table
 *  @param data
 *
 *  @return
 */
- (BOOL)insertDataWithTable: (NSString *)table columnData: (NSDictionary *)data;

/**
 *  更新表数据
 *
 *  @param table
 *  @param iName
 *  @param iData
 *  @param data
 *
 *  @return
 */
- (BOOL)updateDataWithTable: (NSString *)table indexName: (NSString *)indexName indexData: (id)indexData columnData: (NSDictionary *)data;

/**
 *  更新表中数据，如不存在则插入
 *
 *  @param table
 *  @param data
 *  @param name
 *  @param iData
 *
 *  @return
 */
- (BOOL)autoUpdateWithTable: (NSString *)table columnData: (NSDictionary *)data indexName: (NSString *)indexName indexData: (id)indexData;


/**
 *  清空表
 *
 *  @param table
 *
 *  @return
 */
- (BOOL)clearDataTable: (NSString *)table;

/**
 *  删除中某条数据
 *
 *  @param table
 *  @param indexName
 *  @param indexData
 *
 *  @return
 */
- (BOOL)deleteDataWithTable: (NSString *)table indexName: (NSString *)indexName indexData: (id)indexData;

/**
 *  查找表中某条数据
 *
 *  @param table
 *  @param iName
 *  @param iData
 *
 *  @return
 */
- (NSDictionary *)queryDataWithTable: (NSString *)table indexName: (NSString *)indexName indexData: (id)indexData;


/**
 *  获取表中全部数据
 *
 *  @param table
 *
 *  @return
 */
- (NSArray *)getAllDataFromTable:(NSString *)table;

@end
