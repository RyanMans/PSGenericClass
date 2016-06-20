//
//  PSSessionInfo.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

/**
 *  这个类库 是主要 用来规划 用户登录数据处理的 ，一套脉络关系
 *
 */


/**
 *  用户登录信息类
 */
@interface  UserSession : PSBaseModel

//这里主要是一些全局性的类库 ，比如 网络，广播中心，数据库等，在这里我们只需要创建 PSSessionInfo一个单列就够了，当然对应的类库我也写了单列方法
@property (nonatomic, strong, readonly) HttpBaseServer * httpServe;
@property (nonatomic, strong, readonly) PSMsgCenter * msgCenter;
@property (nonatomic, strong, readonly) PSLocalDataStorage * dataStorage;

// 基础信息(登录时获取到的一些常用的信息)
@property (nonatomic, strong, readonly) NSString *mobile;
@property (nonatomic, strong, readonly) NSString *accessToken;
@property (nonatomic, strong, readonly) NSString *guid;

// IM专用(有聊天时，这主要是属于聊天的一些信息)
@property (nonatomic, assign, readonly) BOOL RCIMConnected;
@property (nonatomic, strong, readonly) NSString *imToken;
@property (nonatomic, strong, readonly) NSString *uid;

// 个人信息(属于登录用户的详细信息)
@property (nonatomic, strong, readonly) UserInfoModel *myInfo;

// 第三方登录信息 (这里列举了 微信)
@property (nonatomic, strong, readonly) NSString *openId;
@property (nonatomic, strong, readonly) NSString *unionId;
@end


#define PSSessionInfoInstance     [PSSessionInfo shared]
/**
 *  登录信息类
 */
@interface PSSessionInfo : NSObject
@property (nonatomic, strong, readonly) UserSession *session;

+ (PSSessionInfo*)shared;


//列举了两个登录模块的接口

// 登录
- (void)userLoginWithToken: (NSString *)token block: (NetDictionaryResponeBlock)block;

//退出
- (void)userQuitWithToken: (NSString *)token block: (NetDictionaryResponeBlock)block;

@end
