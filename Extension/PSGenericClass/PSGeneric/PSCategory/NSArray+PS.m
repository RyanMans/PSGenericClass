//
//  NSArray+PS.m
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
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
