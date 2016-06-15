//
//  NSDictionary+PS.h
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PS)
/**
 *   将字典转化成 二进制数据
 *
 *  @return  二进制数据
 */
-(NSData*)toJsonData;
/**
 *  将字典转化成 JSON字符串
 *
 *  @return JSON字符串
 */
-(NSString*)toJsonString;

@end
