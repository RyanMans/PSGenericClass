//
//  PSFileManager.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

// 简写log宏
#ifdef  DEBUG
#define PSLog(...)  NSLog(__VA_ARGS__)
#else
#define PSLog(...)

#endif

#define PSFileManagerInStance    [PSFileManager getInstance]

/**
 *  文件管理类库，提供文件的创建 删 存等常用方法
 */

@interface PSFileManager : NSObject

+ (PSFileManager*)getInstance;

/**
 *  获取Caches目录路径
 *
 *  @return Caches目录路径
 */
-(NSString*)getCachesDirectory;
/**
 *  获取Documents目录路径
 *
 *  @return Documents目录路径
 */
-(NSString*)getDocumentDirectory;

/**
 *  获取tmp目录路径
 *
 *  @return tmp目录路径
 */
-(NSString*)getTemporaryDirectory;
/**
 *   获取沙盒主目录路径
 *
 *  @return  沙盒主目录路径
 */
-(NSString*)getHomeDirectory;
/**
 *  获取当前程序下的 一个资源路径
 *
 *  @param resource  名字
 *  @param type      文件类型
 *
 *  @return 资源路径
 */
-(NSString*)getpathForResource:(NSString*)resource type:(NSString*)type;
#pragma mark -传入文件名 生成文件目录路径-
/**
 *  传入文件名 获取主目录下的 文件目录路径
 *
 *  @param filename
 *
 *  @return
 */
-(NSString*)getHomeDirectory:(NSString*)filename;

/**
 *  传入文件名 获取caches目录下的 文件目录路径
 *
 *  @param filename
 *
 *  @return
 */
-(NSString*)getCachesDirectory:(NSString*)filename;

/**
 *  传入文件名 获取docments目录下的 文件目录路径
 *
 *  @param filename
 *
 *  @return
 */
-(NSString*)getDocumentDirectory:(NSString*)filename;

/**
 *  传入文件名 获取temp目录下的 文件目录路径
 *
 *  @param filename
 *
 *  @return
 */
-(NSString*)getTemporaryDirectory:(NSString*)filename;

#pragma mark -获取数据-
/**
 *  获取路径目录下的所有文件名
 *
 *  @param directory 目录路径
 *
 *  @return
 */
-(NSArray*)getAllfileNameByPath:(NSString*)directory;

/**
 *  获取文件数据
 *
 *  @param filePath 文件路径
 *
 *  @return
 */
-(NSData*)getFileDataByPath:(NSString*)filePath;

#pragma mark -文件存储-

/**
 *  将二进制数据存入指定路径中
 *
 *  @param data     二进制数据
 *  @param filePath  文件路径
 *
 *  @return
 */
-(BOOL)saveDataToFile:(NSData*)data filePath:(NSString*)filePath;

#pragma mark -文件操作-
/**
 *  传入文件路径   创建一个文件目录
 *
 *  @param filename 文件名
 *
 *  @return
 */
-(BOOL)createDirectory:(NSString*)directory;
/**
 *  判断路径是否存在
 *
 *  @param filepath
 *
 *  @return
 */
-(BOOL)fileExists:(NSString*)filepath;

/**
 *  将A目录下的东西移动到B目录
 *
 *  @param nowparh 要移动到的目录
 *  @param prePath 旧目录
 *
 *  @return
 */
-(BOOL)moveDiectory:(NSString*)nowparh prePath:(NSString*)prePath;

/**
 *  将A目录下的东西复制到B目录
 *
 *  @param nowparh 要复制到的目录
 *  @param prePath 旧目录
 *
 *  @return
 */
-(BOOL)copyDirectory:(NSString*)nowpath prepath:(NSString*)prepath;
/**
 *  删除路径
 *
 *  @param filePath
 *
 *  @return
 */
-(BOOL)deleteDirectory:(NSString*)filePath;

#pragma mark -NSUserDefaults-
/**
 *  取值
 *
 *  @param key
 *
 *  @return
 */
- (id)UserDefaultsObjectForkey:(NSString*)key;
/**
 *  存值
 *
 *  @param value
 *  @param key   
 */
- (void)UserDefaultsSetValue:(id)value forKey:(NSString*)key;
/**
 *  删值
 *
 *  @param key 
 */
- (void)UserDefaultsRemoveObjectForKey:(NSString*)key;

@end
