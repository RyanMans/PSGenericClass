//
//  HttpServer.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#ifndef EJYHttpServer_h
#define EJYHttpServer_h


// 服务器协议版本
#define EJY_SERVER_VERSION    @"ejy/v2"   // app
#define EJY_ELEARN_VERSION    @"ejy/v2"   //Elearning

// 模块url
#define http_ModuleUrl(x)  [NSString stringWithFormat:@"%@/%@",EJY_SERVER_VERSION,x]


//IM网络环境
#define IMForInterTest     @"maizhi#zkesf"           // 内网测试
#define IMForOuterTest     @"maizhi#zkesf4test"     //  外网测试
#define IMForProduct       @"maizhi#zkesf4product"  //  正式环境


//网络接口设置(登录 注册)
#define USE_DEBUG_API  0     //  0 - 测试 , 1 - 正式

#if  USE_DEBUG_API

     //1.正式环境
#define EJY_AppServer_Url       @"http://api.xk.yijianyao.com"                 //app域名
#define EJY_Elearning_Url       @"http://121.201.96.250:8088/eLearning"        //elearning域名
#define HXIMFor_AppKey          IMForOuterTest                                 //IM key

#else

     //0.测试环境

#define EJY_AppServer_Url       @"http://api.xk.yijianyao.com"                 //app域名
#define EJY_Elearning_Url       @"http://121.201.96.250:8088/eLearning"        //elearning域名
#define HXIMFor_AppKey          IMForOuterTest                                 //IM key

#endif


//网络（建议使用 类目作为 模块 去管理 该模块接口）
#import "HttpBaseServer.h"
#import "HttpBaseServer+PSMC.h"




#endif /* EJYHttpServer_h */
