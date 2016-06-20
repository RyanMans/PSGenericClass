//
//  HttpBaseServer.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

// 获取网络数据代码
#define getNetCode(dict)            ((!dict) ? - 1 : ((NSNumber*)dict[@"code"]).integerValue)
#define getNetErrCode(dict)         ((!dict) ? - 1 : ((NSNumber*)dict[@"errCode"]).integerValue)

// 获取网络数据消息
#define getNetMessage(dict)         ((NSString *)dict[@"msg"])
#define getNetErrMessage(dict)      ((NSString *)dict[@"errMsg"])

// 获取网络数据数据
#define getNetData(dict)         dict[@"data"]


#define HttpServerInstance       [HttpBaseServer shared]

/**
 *  网络服务类 作为网络服务支撑。（各模块 接口 ，建议使用该类类目的方式创建－－参考 HttpBaseServe+PSMC）
 */
@interface HttpBaseServer : NSObject

+ (HttpBaseServer*)shared;

#pragma mark - Net Method -

/**
 *  EJY app 接口端 网络调用
 *
 *  @param url    模块地址  格式 @"/xxx/xxx"
 *  @param param  参数
 *  @param isPost get/NO  post/YES
 *  @param block
 *
 *  @return
 */
- (BOOL)httpServerWithUrl:(NSString*)url param:(NSDictionary*)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block;

/**
 *  EJY Eleaning 后台的
 *
 *  @param url     模块地址   格式 @"/xxx/xxx"
 *  @param param   参数
 *  @param isPost  get/NO  post/YES
 *  @param block
 *
 *  @return
 */
- (BOOL)httpElearningServerWithUrl:(NSString*)url param:(NSDictionary*)param isPost:(BOOL)isPost  block:(NetDictionaryResponeBlock)block;

/**
 *  EJY other
 *
 *  @param baseUrl 域名（如有版本好，请自行拼接在该字段）
 *  @param path    模块地址  格式 @"/xxx/xxx"
 *  @param param   参数
 *  @param isPost  get/NO  post/YES
 *  @param block
 *
 *  @return
 */
- (BOOL)httpServerWithBaseUrl:(NSString *)baseUrl  path:(NSString*)path param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block;

@end
