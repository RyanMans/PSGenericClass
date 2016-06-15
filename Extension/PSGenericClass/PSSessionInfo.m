//
//  PSSessionInfo.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSSessionInfo.h"

@interface UserSession ()
//这里主要是一些全局性的类库 ，比如 网络，广播中心，数据库等，在这里我们只需要创建 PSSessionInfo一个单列就够了，当然对应的类库我也写了单列方法

@property (nonatomic, strong) HttpBaseServe * httpServe;
@property (nonatomic, strong) PSMsgCenter * msgCenter;
@property (nonatomic, strong) PSLocalDataStorage * dataStorage;

// 基础信息(登录时获取到的一些常用的信息)
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *guid;

// IM专用(有聊天时，这主要是属于聊天的一些信息)
@property (nonatomic, assign) BOOL RCIMConnected;
@property (nonatomic, strong) NSString *imToken;
@property (nonatomic, strong) NSString *uid;

// 个人信息(属于登录用户的详细信息)
@property (nonatomic, strong) UserInfoModel *myInfo;

// 第三方登录信息 (这里列举了 微信)
@property (nonatomic, strong) NSString *openId;
@property (nonatomic, strong) NSString *unionId;
@end
@implementation UserSession
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _myInfo = NewClass(UserInfoModel);
        _msgCenter = NewClass(PSMsgCenter);
        _httpServe = NewClass(HttpBaseServe);
        _dataStorage = NewClass(PSLocalDataStorage);
    }
    return self;
}
- (void)quitApp
{
    if (_dataStorage) {
        
        //断开 im 聊天连接(列举了下 融云的)
        
        //[[RCIM sharedRCIM] logout];
        //[[RCIM sharedRCIM] disconnect];
        
        //关闭数据库
        [_dataStorage close];
    }

}


@end


static PSSessionInfo * _sessionInfo = nil;
@interface PSSessionInfo()

@end
@implementation PSSessionInfo
+ (PSSessionInfo*)shared
{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sessionInfo = [[PSSessionInfo alloc] init];
    });
    
    //while 语句 可不加
    while ( nil == _sessionInfo ) [NSThread sleepForTimeInterval:0.1];
    return _sessionInfo;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)resetState
{
    [_session quitApp];
    _session = NewClass(UserSession);
}


#pragma mark -Net-
- (void)userLoginWithToken:(NSString *)token block:(NetDictionaryResponeBlock)block
{
    //之前
    [PSSessionInfoInstance resetState];

    /* 成功后
     
     1.先登录接口 数据 获取 信息
     
     2.UserSession 开始对用户登录信息类  属性信息赋值
     
     3.打开数据库文件
     
     4.有聊天的话 配置聊天
     
     5......
     */
    
    //距离  guid 是一个用户的唯一标识别 10086
    
    
    _session.guid = @"10086";
    
    //打开数据库文件 (对于有不同用户登录的app ，本人建议 是 用uid 去创建 一个个人单独的sqlite文件，而不是 一个app只有一个sqlite文件，当然对于个别app 存在不登录 也能拿到数据的 ，而且是多个接口，这种情况具体考虑)
//    [_session.dataStorage open:_session.guid];
    
    /**
     *  .....
     */
}


- (void)userQuitWithToken:(NSString *)token block:(NetDictionaryResponeBlock)block
{
    
    /* 成功后
     
     1.清空用户登录 存储的信息
     
     2.关闭数据库文件
     
     3.有聊天的话 断开聊天配置
     
     4......

     */
    
    //之后
    [PSSessionInfoInstance resetState];
    
}


@end
