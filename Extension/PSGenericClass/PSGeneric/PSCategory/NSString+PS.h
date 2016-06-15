//
//  NSString+PS.h
//  HeartDoctor
//
//  Created by admin on 16/4/8.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PS)

/**
 *  去除字符串前后空白字符
 *
 *  @return 新字符串
 */
- (NSString *)removeWSSpace;

/**
 *  是否整型
 *
 *  @return YES/NO
 */
- (BOOL)isInterger;

/**
 *  转换成NSData
 *
 *  @return 转换后的data
 */
- (NSData *)toData;

/**
 *  json字符串转对象
 *
 *  @return NSArray或NSDictionary
 */
- (id)jsonToObject;

//有效手机号码
- (NSString*)isEffectiveMobileNumber;

/**
 *  判断是否是手机号码
 *
 *  @return
 */
- (BOOL)isMobileNumber;


/**
 *  只有数字
 *
 *  @return
 */
- (NSString *)onlyNumbers;

/**
 *  返回中文拼音
 *
 *  @param isShort 是否返回拼音缩写
 *
 *  @return
 */
- (NSString *)toPinyinEx:(BOOL)isShort;

@end
