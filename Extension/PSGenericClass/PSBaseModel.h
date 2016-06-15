//
//  PSBaseModel.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/4/15.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

/*

  模型基类，所有模型必须继承该类,管理全局数据模型
 
 */

@interface PSBaseModel : NSObject


/**
 *  字典转模型
 *
 *  @param dict
 *
 *  @return
 */
+ (instancetype)modelWithDictionary:(NSDictionary*)dict;

/**
 *  字典数组转化成模型数组
 *
 *  @param arrays
 *
 *  @return
 */
+ (NSArray*)modelWithKeyValuesArrays:(NSArray*)arrays;

/**
 *  模型转字典
 *
 *  @return
 */
- (NSDictionary*)dictionary;

/**
 *  模型数组转化成 字典数组
 *
 *  @param models
 *
 *  @return
 */
+ (NSArray*)keyValuesArrayWithObjectArray:(NSArray*)models;

@end
