//
//  NSObject+PS.m
//  EJY3EDIT
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "NSObject+PS.h"

@implementation NSObject (PS)
- (NSDictionary *)toDictionaryWithJSON:(id)json
{
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary * dict = nil;
    NSData * jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]])
    {
        dict = json;
    }
    else if ([json isKindOfClass:[NSString class]])
    {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    }
    else if ([json isKindOfClass:[NSData class]])
    {
        jsonData = json;
    }
    if (jsonData)
    {
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dict isKindOfClass:[NSDictionary class]]) dict = nil;
    }
    return dict;
}

@end
