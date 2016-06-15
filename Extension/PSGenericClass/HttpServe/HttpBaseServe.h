//
//  HttpBaseServe.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HttpBaseServeInstance     [HttpBaseServe shared]
// 获取网络数据代码
#define getNetCode(dict)         ((!dict) ? - 1 : ((NSNumber*)dict[@"code"]).integerValue)
// 获取网络数据消息
#define getNetMessage(dict)      ((NSString *)dict[@"msg"])
// 获取网络数据数据
#define getNetData(dict)         dict[@"data"]

#define  APPSERVER_URL   @"www.baidu.com" //此处为 接口域名 。不建议写在此处。应创建相关h文件 配置网络相关的宏 以及 对应的key


typedef void(^NetResponeBlock)(id respone, NSError *error, id userParam);
typedef void(^NetDictionaryResponeBlock)(NSDictionary *respone, NSError *error, id userParam);


/**
 *  网络类库。作为网络服务支撑。（各模块 接口 ，建议使用该类类目的方式创建－－参考 HttpBaseServe+PSMC）
 */
@interface HttpBaseServe : NSObject
+(HttpBaseServe*)shared;

#pragma mark -JSON-
// 网络服务
- (BOOL)httpServeWithUrl:(NSString*)url param:(NSDictionary*)param  isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block;

//其他的(通用的)
- (BOOL)httpServeWithBaseUrl:(NSString *)baseUrl Url:(NSString *)url param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block;

- (BOOL)urlGETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))success fail:(void (^)(NSString *))fail;

- (BOOL)urlPOSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))success fail:(void (^)(NSString *))fail;


#pragma mark -From data-

/**
 *  表单数据提交，适合音频流 以及 图片流 等二进制数据提交。在这里举个列子
 */
- (BOOL)httpServeFromDataWithBaseUrl:(NSString *)baseUrl Url:(NSString *)url token:(NSString *)token param:(NSDictionary *)param block:(NetDictionaryResponeBlock)block;

@end
