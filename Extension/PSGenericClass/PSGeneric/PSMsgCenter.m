//
//  PSMsgCenter.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//
#import "PSMsgCenter.h"
#import "PSMethodTools.h"
/**
 *  消息对象
 */
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

- (BOOL)addReceiver:(id<PSMsgDispatcherDelegate>)obj type:(NSString *)type
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
        id<PSMsgDispatcherDelegate> obj = ps.object;
        [obj didReceivedMessage:msg msgDispatcher:self userParam:param];
    }
}


#pragma mark -NSNotificationCenter-
void addPost(id observer, SEL selector,NSString *name)
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:nil];
}

void post(NSString *name,id object)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

void removePost(id observer,NSString *name)
{
    if (name == nil || name.length == 0)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:nil];
    }
}
@end
