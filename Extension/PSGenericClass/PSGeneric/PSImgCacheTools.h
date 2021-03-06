//
//  PSImgCacheTools.h
//  EJY3EDIT
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define  PSImgCacheToolsInStance   [PSImgCacheTools shared]

/**
 * 图片管理类库。提供一套本地app自身的图片管理，和一些第三方的sdwimage等作为区分，处理一些特殊的图片
 */
@interface PSImgCacheTools : NSObject
@property (nonatomic,copy,readonly)NSString * imageCacheDir;

/**
 *  单列
 *
 *  @return
 */
+ (PSImgCacheTools*)shared;

/**
 *  初始化PSImgCacheTools
 *
 *  @param cacheDir 使用自定义缓存目录,如果为Nil,则使用默认缓存目录imageCache
 *
 *  @return
 */
- (id)initWithCacheDir:(NSString*)cacheDir;

#pragma mark -imageCache-
/**
 *  获取图片名
 *
 *  @param url
 *
 *  @return
 */
- (NSString *)getCacheImageName:(NSString *)url;

/**
 *  获取一个默认的图片路径 imageCache
 *
 *  @param imageName
 *
 *  @return
 */
- (NSString*)getCacheImagePath:(NSString*)imageName;

/**
 *  获取图片
 *
 *  @param imageName
 *
 *  @return
 */
- (UIImage*)getCacheImageWithUrl:(NSString*)url;

/**
 *  保存图片
 *
 *  @param image
 *  @param imageName
 */
- (void)saveCacheImage:(UIImage*)image url:(NSString*)url;

/**
 *  清空图片缓存(单个文件夹)
 */
- (void)cleanImageCache;

/**
 *  清空图片缓存(全部文件夹)
 */
- (void)cleanAllImageCache;

@end

