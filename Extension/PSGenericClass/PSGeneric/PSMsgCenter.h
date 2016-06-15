//
//  PSMsgCenter.h
//  EJY
//
//  Created by Ryan_Man on 16/4/13.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSMsg.h"

/**
 *   广播中心，用于全局的消息通知，监听 以及 事件响应。效果等同于通知中心
     起初本想使用 通知，但荐于通知中心，一些细节上的处理不好管理，所以还是使用兼容性 较强的代理
 *
 */

#define PSMsgCenterInstance   [PSMsgCenter shared]
@class PSMsgCenter;
@protocol MsgDispatcherDelegate <NSObject>
@required
- (void)didReceivedMessage: (NSString *)type msgDispatcher: (PSMsgCenter *)sender userParam: (id)param;
@end

@interface PSMsgCenter : NSObject
+ (instancetype)shared;

/**
 *  发送消息(支持多个或单个)
 *
 *  @param msg
 *  @param param
 */
- (void)sendMessage: (NSString *)msg userParam: (id)param;

/**
 *  发送消息 (仅仅支持单个)
 *
 *  @param type
 *  @param param
 */
- (void)dispatchMessageAsync: (NSString *)msg userParam: (id)param;


/**
 *  添加消息监听
 *
 *  @param obj
 *  @param type
 *
 *  @return
 */
- (BOOL)addReceiver: (id<MsgDispatcherDelegate>)obj type: (NSString *)type;

@end
