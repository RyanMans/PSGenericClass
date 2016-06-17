//
//  PSMsgCenter.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

//PSMsgDispatcherDelegate

@class PSMsgCenter;
@protocol PSMsgDispatcherDelegate <NSObject>
@required
/**
 *  接收消息，并响应事件
 *
 *  @param type   消息类型
 *  @param sender 消息发送者
 *  @param param  传递的参数
 */
- (void)didReceivedMessage: (NSString *)type msgDispatcher: (PSMsgCenter *)sender userParam: (id)param;
@end


#define PSMsgCenterInstance   [PSMsgCenter shared]
/**
 *  广播中心 ：实现消息传递，消息接收，消息事件响应
 */
@interface PSMsgCenter : NSObject

+ (instancetype)shared;

/**
 *  发送消息(支持多个或单个)
 *
 *  @param msg     消息类型
 *  @param param   传递的参数
 */
- (void)sendMessage: (NSString *)msg userParam: (id)param;

/**
 *  发送消息 (仅仅支持单个)
 *
 *  @param msg     消息类型
 *  @param param    传递的参数
 */
- (void)dispatchMessageAsync: (NSString *)msg userParam: (id)param;


/**
 *  添加消息监听(是异步发送消息，如有ui操作，请再重回主线程)
 *
 *  @param obj    消息监听者
 *  @param type   消息类型
 *
 *  @return
 */
- (BOOL)addReceiver:(id<PSMsgDispatcherDelegate>)obj type:(NSString *)type;


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

@end
