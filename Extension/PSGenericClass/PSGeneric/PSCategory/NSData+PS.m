//
//  NSData+PS.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/14.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "NSData+PS.h"

@implementation NSData (PS)
-(id)toObject
{
    NSError * error;
    id object = [NSJSONSerialization JSONObjectWithData:self options:(NSJSONReadingAllowFragments) error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return object;
}
@end
