//
//  PSLocalDataStorage.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PSLocalDataStorageInstance  [PSLocalDataStorage shared]

/**
 *  数据类库，作为数据存储
 */
@interface PSLocalDataStorage : NSObject
+ (PSLocalDataStorage*)shared;

/**
 *  打开数据库文件 (适用于包含登录的app，可传入不同登录用户的uid 在同一设备上打开各自的数据库文件)
 *
 *  @param fileName
 */
- (void)open:(NSString *)fileName;

/**
 *  数据库关闭
 */
- (void)close;


#pragma mark -列子-

//手机通讯录
- (void)addAllMobileContactList:(NSArray*)list;

- (void)addMobileContactMessage:(NSDictionary*)dict;

- (void)removeAllMobileContactList;

- (void)removeMobileContactMessage:(NSString*)recordID;

- (NSArray*)getAllMobileContactList;

- (NSDictionary*)getMobileContactMessage:(NSString*)recordID;


@end
