//
//  PSLocalDataStorage.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSLocalDataStorage.h"
@interface PSLocalDataStorage ()
{
    PSDataStorage * _dataBase; //（这是我基于fmdb重新封装出来的数据库方法，包含增 删 改 查）创建表时根据具体情况需写SQL语句，其他方式则不用，我类库内部已经封装好
}
@end

@implementation PSLocalDataStorage
+ (PSLocalDataStorage*)shared
{
    static PSLocalDataStorage * dataStorage = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dataStorage = NewClass(PSLocalDataStorage);
    });
    return dataStorage;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //测试 (建议放在 登录成功后)
        
        _dataBase = NewClass(PSDataStorage);
        [self open:@"test"];
    }
    return self;
}

- (void)open:(NSString *)fileName
{
    
//  NSString * path =  [PSImgCacheToolsInStance getCacheImagePath:@"aaaa.txt"];
    NSString * directory = [PSFileManagerInStance getCachesDirectory:@"LocalData"];
    [PSFileManagerInStance createDirectory:directory];

   NSString * sqlite =  [self ecodeString:directory name:fileName];

    //加个编码(最好)
    
    [_dataBase openDataBase:sqlite];
    
    [self createTableList];
    
}
- (NSString*)ecodeString:(NSString*)directory name:(NSString*)name
{
    
#ifdef DEBUG
    NSString *tstr = [NSString stringWithCString:__DATE__ encoding:NSUTF8StringEncoding];
#else
    NSString *tstr = [NSString stringWithCString:__TIMESTAMP__ encoding:NSUTF8StringEncoding];
#endif
    
    NSString * sqlite =  [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.sqlite",name,tstr]];
    sqlite = [sqlite stringByReplacingOccurrencesOfString:@":" withString:@""];
    sqlite = [sqlite stringByReplacingOccurrencesOfString:@" " withString:@""];
    return sqlite;
}

- (void)close
{
    [_dataBase closeDataBase];
}
#pragma mark - 创建表的两种方式比较 -

//使用key－value 这种散列式的方式创建表，可以清晰的知道具体字段结构，但如果接口返回的数据突然增加字段时，则缺乏灵活性，需重新再添加该字段才能重现存入数据，否则则报错，减少字段则不影响。

//创建表列表1.需使用SQL语句，可以一开始就创建好。
- (void)createTableList
{
    
     BOOL bExist = NO;
    
    bExist = [_dataBase isExistsDataTable:@"mobileContact"];
    if (!bExist)
    {
        //sqlite语句 只需要 写表的创建就可以了 ，其他的方法 我类库已经写了方法
        
        //这里列举了 字符串 和 integer 类型的 创建 语法 ，一般就这两种，当然 可能存在数据嵌套的，比如 字典里面有数组 或 字典，这种情况的话，数组的话，看数据长度，如果只有少量数据 ，建议把数据转成一个 jsonstring存入，字典的话，当然也是 jsonstring存入 ,取的时候 再转成 nsarry nsdictionary
            [_dataBase executeUpdateWithSQL:@"create table mobileContact(mobile text DEFAULT(''),email text DEFAULT(''),name text DEFAULT(''),avatarUrl text DEFAULT (''),recordID text DEFAULT(''),mobileArr text DEFAULT(''),emailArr text DEFAULT(''))" params:nil block:nil];
    }
    //列子
    /*
     //用户信息表
    bExist = [_database isExistsDataTable:@"user"];
    if ( !bExist )
    {
        NSString *user = @"create table %@(unionid text DEFAULT(''),openid text DEFAULT (''),guid text DEFAULT(''),uid text DEFAULT (''),username text DEFAULT (''),imtoken text DEFAULT (''),mobile text DEFAULT (''),email text DEFAULT (''),avatar text DEFAULT (''),nickname text DEFAULT (''),corptoken text DEFAULT (''),realname text DEFAULT (''),signature text DEFAULT (''),gender integer DEFAULT (0),address text DEFAULT (''),qq text DEFAULT (''),wechat text DEFAULT (''),birthday text DEFAULT (''),createtime text DEFAULT (''),qrcode text DEFAULT (''),corpid text DEFAULT (''),shortname text DEFAULT (''),name text DEFAULT (''),corpname text DEFAULT (''),logo text DEFAULT (''),corplogo text DEFAULT (''),code text DEFAULT (''),corpcode text DEFAULT (''),department text DEFAULT (''),position text DEFAULT (''),worknumber text DEFAULT (''),corpphone text DEFAULT (''),corpextphone text DEFAULT (''),corpemail text DEFAULT (''),isjoin integer DEFAULT (0),role text DEFAULT (''),corpqrcode text DEFAULT (''),user_version integer DEFAULT (0))";
        [_database executeUpdateWithSQL:[NSString stringWithFormat:user, @"user"] params:nil block:ub];
    }
    
    */
}

//创建表列表2.根据传入的字典 去创建表。
- (void)createMobileTable:(NSDictionary*)dict
{
    //也可以用 字典 创建表
    BOOL  bExist = [_dataBase isExistsDataTable:@"mobileContact"];
    if (!bExist) {
        
        [_dataBase createDataTable:@"mobileContact" fromDemoData:dict];
    }
}


- (void)addAllMobileContactList:(NSArray *)list
{
    for (NSDictionary * dict in list)
    {
        [self addMobileContactMessage:dict];
    }
}
- (void)addMobileContactMessage:(NSDictionary *)dict
{
    if (dict.count == 0 || !dict) return;
    
    NSString * tableName = @"mobileContact";
    NSString * indexName = @"recordID";
    NSMutableDictionary * temp = dict.mutableCopy;
    
    [temp removeObjectForKey:@"fullPY"];
    [temp removeObjectForKey:@"firstPY"];
    
    
    temp[@"mobileArr"] = [temp [@"mobileArr"] toJsonString];
    temp[@"emailArr"] = [temp [@"emailArr"] toJsonString];;
    
    if ([_dataBase existsRowWithTable:tableName indexName:indexName indexData:temp[indexName]]) {
        
        [_dataBase updateDataWithTable:tableName indexName:indexName indexData:temp[indexName] columnData:temp];
    }
    else
    {
        [_dataBase insertDataWithTable:tableName columnData:temp];
    }
}
- (void)removeAllMobileContactList
{
    NSString * tableName = @"mobileContact";
    [_dataBase clearDataTable:tableName];
}

- (void)removeMobileContactMessage:(NSString *)recordID
{
    if (recordID.length == 0 || !recordID) return;
    NSString * tableName = @"mobileContact";
    NSString * indexName = @"recordID";
    [_dataBase deleteDataWithTable:tableName indexName:indexName indexData:recordID];
}

- (NSArray*)getAllMobileContactList
{
    NSString * tableName = @"mobileContact";

    NSArray * arr = [_dataBase getAllDataFromTable:tableName];
    
    NSMutableArray * temp = NewMutableArray();
    
    for (NSDictionary * dict in arr)
    {
        NSMutableDictionary * tempDict = dict.mutableCopy;
        tempDict[@"mobileArr"] = [tempDict [@"mobileArr"] jsonToObject];
        tempDict[@"emailArr"] = [tempDict [@"emailArr"] jsonToObject];
        if (tempDict.count) {
            [temp addObject:tempDict];
        }
    }
    
    return temp.count ? temp : @[];
}
- (NSDictionary*)getMobileContactMessage:(NSString *)recordID
{
    if (recordID.length == 0 || !recordID) return @{};
    NSString * tableName = @"mobileContact";
    NSString * indexName = @"recordID";

    NSDictionary * dict = [_dataBase queryDataWithTable:tableName indexName:indexName indexData:recordID];
    NSMutableDictionary * tempDict = dict.mutableCopy;
    tempDict[@"mobileArr"] = [tempDict [@"mobileArr"] jsonToObject];
    tempDict[@"emailArr"] = [tempDict [@"emailArr"] jsonToObject];    
    return tempDict.count?tempDict : @{};
}

@end
