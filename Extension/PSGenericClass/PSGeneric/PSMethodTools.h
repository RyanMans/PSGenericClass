//
//  MethodTools.h
//  Method
//
//  Created by ibos on 15/12/14.
//  Copyright © 2015年 ibos. All rights reserved.
//

#ifndef MethodTools_h
#define MethodTools_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MethodDefine.h"

typedef void(^emptyBlock)();
typedef NSString*(^getStringBlock)();

typedef void(^boolBlock) (BOOL respone);
typedef void(^integerBlock) (NSInteger respone);
typedef void(^stringBlock) (NSString *respone);
typedef void(^dictionaryBlock) (NSDictionary *respone);
typedef void(^arrayBlock) (NSArray *respone);


// 主线程
void runBlockWithMain(dispatch_block_t block);
// 异步线程
void runBlockWithAsync(dispatch_block_t block);
//先异步 后同步
void runBlock(dispatch_block_t asyncBlock, dispatch_block_t syncBlock);


/**
 *  获取系统版本
 *
 *  @return
 */
NSString *getVersion();

/**
 *  获取设备名称
 *
 *  @return 设备名称
 */
NSString *getDeviceName();

#pragma mark -Url 触发-

/**
 *  打开短信界面
 *
 *  @param number 电话号码
 */
void openSMS(NSString *number);

/**
 *  调用浏览器
 *
 *  @param url 网址
 */
void openUrl(NSString *url);

/**
 *  调用打电话界面
 *
 *  @param number 电话号码
 */
void openCall(NSString *number);

/**
 *  打开Email
 *
 *  @param email email地址
 */
void openEmail(NSString *email);

/**
 *  跳转到AppStore
 *
 *  @param appid APPID
 */
void gotoAppStore(NSString *appid);


#pragma mark -NSNotificationCenter -
/**
 *  添加一个消息监听到通知中心
 *
 *  @param observer
 *  @param selector
 *  @param name     监听的名字
 */
void addPost(id observer, SEL selector,NSString *name);
/**
 *  通过名字删除消息监听
 *
 *  @param observer
 *  @param name     监听的名字
 */
void removePost(id observer,NSString *name);
/**
 *  发送一个消息监听
 *
 *  @param name   监听的名字
 *  @param object 发送的数据，没有就填nil
 */
void post(NSString *name,id object);

#pragma mark -时间处理 -
/**
 *  得到当前的时间戳
 *
 *  @return 时间戳
 */
long long  getCurrentTimestamp ();

/**
 *  得到当前的时间 按一定格式生成的时间字符串
 *
 *  @return 时间字符串
 */
NSString * getCurrentDateString (NSString * format);

/**
 *  把一个指定的日期转换成时间戳
 *
 *  @param date 指定日期的实例
 *
 *  @return 时间戳
 */
long long dateToTimestamp(NSDate *date);

/**
 *  把一个指定的时间字符串转换成时间戳
 *
 *  @param date 指定日期的实例
 *
 *  @return 时间戳
 */
long long stringToTimestamp(NSString * time);

/**
 *  把一个时间戳转换成一个字典
 *
 *  @param timestamp 时间戳
 *
 *  @return 目前支持{"year":"1992","month":"2","day":"22"}
 */
NSDictionary* timestampToDictionary(long long timestamp);
/**
 *  把一个时间戳转换成日期对象
 *
 *  @param timestamp 时间戳
 *
 *  @return 例如"1990-06-08"
 */
NSString* timestampToString(long long timestamp);

#pragma mark -Extend-
/**
 *  从字符串中得到拼音
 *
 *  @param source  中文
 *  @param isShort 返回的是否缩写
 *
 *  @return 中文拼音
 */
NSString *getPinyin(NSString * source,BOOL isShort);

/**
 *  检查字符串是否EMAIL格式
 *
 *  @return YES/NO
 */
BOOL isEmailAddress(NSString * text);

/**
 *  是否字符型
 *
 *  @return YES/NO
 */
BOOL isCharacter(NSString* text);

/**
 *  是否整型
 *
 *  @return YES/NO
 */
BOOL isInterger(NSString *  text);

/**
 *  判断键盘是否是中文输入模式
 *
 *
 *
 *  @return
 */
BOOL isChineseTextInputMode();



#endif /* MethodTools_h */
