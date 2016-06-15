//
//  PSMsgCenter.m
//  EJY
//
//  Created by Ryan_Man on 16/4/13.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSMsgCenter.h"

@interface PSMsgObject : NSObject
@property (nonatomic,weak,readonly)id object;
@end

@implementation PSMsgObject
- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        _object = object;
    }
    return self;
}
+ (instancetype)shared:(id)object
{
    PSMsgObject * obj = [[self alloc] initWithObject:object];
    return obj;
}
@end

@interface PSMsgCenter ()
{
    NSMutableDictionary *_msgTree;
    NSMutableDictionary *_receivers;
}
@end
@implementation PSMsgCenter
- (instancetype)init
{
    self = [super init];
    if (self) {
        _msgTree = [@{} mutableCopy];
        _receivers = [@{} mutableCopy];
    }
    return self;
}

+ (instancetype)shared
{
    static PSMsgCenter * _msgCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _msgCenter  = [[PSMsgCenter alloc] init];
    });
    return _msgCenter;
}

#pragma mark -Method-
- (void)sendMessage:(NSString *)msg userParam:(id)param
{
    NSLog(@"translate message: %@", msg);
    
    [self dispatchMessageAsync:msg userParam:param];
    
    //支持群发
    NSArray * temp = _msgTree[msg];
    for (NSString * key in temp)
    {
        [self sendMessage:key userParam:param];
    }
}

- (void)dispatchMessageAsync:(NSString *)msg userParam:(id)param
{
    runBlockWithAsync(^{[self dispatchMessage:msg userParam:param];});
}

- (BOOL)addReceiver:(id<MsgDispatcherDelegate>)obj type:(NSString *)type
{
    NSMutableArray * temp = _receivers[type];
    
    if (nil == temp) {
        temp = [[NSMutableArray alloc] initWithCapacity:4UL];
        [_receivers setObject:temp forKey:type];
    }
    [temp addObject:[PSMsgObject shared:obj]];
    return YES;
}

- (void)dispatchMessage: (NSString *)msg userParam: (id)param
{
    NSMutableArray *temp = _receivers[msg];
    if (nil == temp) return;
    
    for (PSMsgObject * ps in temp)
    {
        id<MsgDispatcherDelegate> obj = ps.object;
        [obj didReceivedMessage:msg msgDispatcher:self userParam:param];
    }
}
@end
