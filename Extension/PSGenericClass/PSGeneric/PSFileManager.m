//
//  PSFileManager.m
//  NetEase
//
//  Created by ibos on 15/8/26.
//  Copyright (c) 2015年 ps. All rights reserved.
//

#import "PSFileManager.h"
@interface PSFileManager ()
@end
@implementation PSFileManager
+ (PSFileManager*)getInstance
{
    static PSFileManager * fm = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        fm = [[PSFileManager alloc] init];
    });
    return fm;
}
#pragma mark -路径获取-

-(NSString*)getHomeDirectory
{
    // 沙盒的主目录路径
    NSString * homeDirectory = NSHomeDirectory();
    return homeDirectory;
}

-(NSString*)getCachesDirectory
{
    // 获取caches 目录路径
    NSArray * caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return caches[0];
}

-(NSString*)getDocumentDirectory
{
    // 获取documents  下路径
    NSArray * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return documents[0];
}

-(NSString*)getTemporaryDirectory
{
    // 获取temp 目录路径
    
    NSString * temp = NSTemporaryDirectory();
    return temp;
}

-(NSString*)getpathForResource:(NSString *)resource type:(NSString *)type
{
    // 当前资源路径
    NSString * path = [[NSBundle mainBundle] pathForResource:resource ofType:type];
    return path;
}
#pragma mark -传入文件名 生成文件目录路径-
-(NSString*)getHomeDirectory:(NSString*)filename
{
    // 沙盒的主目录路径下，某文件目录路径
    NSString * homeDirectory = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    //[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),filename];
    return homeDirectory;
}

-(NSString*)getCachesDirectory:(NSString*)filename
{
    // 获取caches 目录路径下，某文件目录路径
    NSArray * caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return  [caches[0] stringByAppendingPathComponent:filename];//[NSString stringWithFormat:@"%@/%@", caches[0],filename];//;
}

-(NSString*)getDocumentDirectory:(NSString*)filename
{
    // 获取documents下，某文件目录路径
    NSArray * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documents[0] stringByAppendingPathComponent:filename];//[NSString stringWithFormat:@"%@/%@", documents[0],filename];
    
}

-(NSString*)getTemporaryDirectory:(NSString*)filename
{
    // 获取temp 目录路径下，某文件目录路径
    
    NSString * temp = NSTemporaryDirectory();
    return  [NSString stringWithFormat:@"%@/%@",temp,filename];
 //[temp stringByAppendingPathComponent:filename];
}
#pragma mark -获取数据-

-(NSArray*)getAllfileNameByPath:(NSString*)directory
{
    // 获取文件目录下的文件名
    if (directory == nil || directory.length == 0) return nil;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([ fileManager fileExistsAtPath:directory])
    {
        NSArray * array = [fileManager subpathsAtPath:directory];
        return array;
    }
    return nil;
}
-(NSData*)getFileDataByPath:(NSString*)filePath
{
    // 获取文件路径下的二进制数据
    if (filePath == nil || filePath.length == 0) return nil;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:filePath])
    {
        NSData * data = [fileManager contentsAtPath:filePath];
        return data;
    }
    return nil;
}

#pragma mark -文件存储-

-(BOOL)saveDataToFile:(NSData*)data filePath:(NSString*)filePath
{
    
    if (filePath == nil || filePath.length == 0) return NO;
        if (data != nil)
        {
            return [data writeToFile:filePath atomically:YES];
        }
    return NO;
    
}

#pragma mark -文件操作-

-(BOOL)fileExists:(NSString *)filepath

{
    if (filepath == nil || filepath.length == 0) return NO;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    return [ fileManager fileExistsAtPath:filepath];
}

-(BOOL)createDirectory:(NSString *)directory
{
    if (directory == nil || directory.length == 0) return NO;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:directory])
    {
        BOOL iscreate = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        return iscreate;
    }
    return YES;
}
-(BOOL)moveDiectory:(NSString*)nowparh prePath:(NSString*)prePath
{
    if (nowparh == nil || nowparh.length == 0) return NO;
    if (prePath == nil || prePath.length == 0) return NO;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:prePath])
    {
        NSError * error;
        [fileManager moveItemAtPath:prePath toPath:nowparh error:&error];
        if (error)
        {
            PSLog(@"error:%@",error);
            
            return NO;
        };
        return YES;
    }
    return NO;
}
-(BOOL)copyDirectory:(NSString*)nowpath prepath:(NSString*)prepath
{
    if (nowpath == nil || nowpath.length == 0) return NO;
    if (prepath == nil || prepath.length == 0) return NO;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:prepath])
    {
        NSError * error;
        [fileManager copyItemAtPath:prepath toPath:nowpath error:&error];
        if (error)
        {
            PSLog(@"error:%@",error);
            return NO;
        }
        return YES;
    }
 
    return NO;
}
-(BOOL)deleteDirectory:(NSString*)filePath
{
    if (filePath == nil || filePath.length == 0) return NO;
    NSFileManager * fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:filePath])
    {
        NSError * error ;
        [fileManager removeItemAtPath:filePath error:&error];
        if (error)
        {
            PSLog(@"error:%@",error);
            return NO;
        }
        return YES;
    }
    
    return NO;
}

#pragma mark -NSUserDefaults-
- (id)UserDefaultsObjectForkey:(NSString *)key
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
- (void)UserDefaultsSetValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)UserDefaultsRemoveObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}



@end
