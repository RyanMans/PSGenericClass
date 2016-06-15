//
//  NSDate+PS.h
//  aaa
//
//  Created by ibos on 16/2/26.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PS)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  返回年月日的字符串
 *
 *  @return 不解释
 */
- (NSString *)dateWithYMDString;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
