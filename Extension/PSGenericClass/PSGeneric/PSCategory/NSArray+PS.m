//
//  NSArray+PS.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "NSArray+PS.h"

@implementation NSArray (PS)
-(NSData*)toJsonData
{
    NSError * error ;
    NSData * data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return data;
}

-(NSString*)toJsonString
{
    
    NSData * data = [self toJsonData];
    
    NSString * json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return json;
}

@end
