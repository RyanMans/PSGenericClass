//
//  NSData+PS.m
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
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
