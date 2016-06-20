//
//  typedef.h
//  EJY3EDIT
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#ifndef typedef_h
#define typedef_h

typedef void(^EmptyBlock)();
typedef NSString*(^GetStringBlock)();

typedef void(^selectorBlock)(id target, SEL selector, id sender);
typedef void(^BoolBlock)(BOOL state);
typedef void(^NSObjectBlock)(id object);
typedef void(^NSStringBlock)(NSString *object);
typedef void(^DictionaryBlock) (NSDictionary *respone);
typedef void(^ArrayBlock) (NSArray *respone);
typedef void(^NetResponeBlock)(id respone, NSError *error, id userParam);
typedef void(^NetDictionaryResponeBlock)(NSDictionary *respone, NSError *error, id userParam);

#endif /* typedef_h */
