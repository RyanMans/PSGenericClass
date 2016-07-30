//
//  PSImgCacheTools.m
//  EJY3EDIT
//
//  Created by Ryan_Man on 16/6/17.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSImgCacheTools.h"
@interface PSImgCacheTools ()
@property (nonatomic,copy)NSString * imageCacheDoc;
@end
@implementation PSImgCacheTools

+ (PSImgCacheTools*)shared
{
    static PSImgCacheTools * imgCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        imgCache = [[PSImgCacheTools alloc] init];
    });
    return imgCache;
}

- (NSString *)imageCacheDoc
{
    if (!_imageCacheDoc)
    {
        _imageCacheDoc = IsSafeString([PSFileManagerInStance getCachesDirectory:@"imageCache"]);
    }
    return _imageCacheDoc;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self imageFloder:nil];
    }
    return self;
}

- (id)initWithCacheDir:(NSString *)cacheDir
{
    self = [super init];
    if (self) {
        
        [self imageFloder:cacheDir];
    }
    return self;
}

- (void)imageFloder:(NSString*)cacheDir
{
    if (cacheDir.length == 0 || !cacheDir )
    {
        cacheDir = @"imageCache";
    }
    _imageCacheDir = [self.imageCacheDoc stringByAppendingPathComponent:IsSafeString(cacheDir)];
    [PSFileManagerInStance createDirectory:_imageCacheDir];
}

#pragma mark -imageCache-
- (NSString *)getCacheImageName:(NSString *)url
{
    if (!url || url.length == 0) return @"";
    
    NSArray *arr = [url componentsSeparatedByString:@"/"];
    NSString * imageName = arr[arr.count - 1];
    BOOL suffix = [self checkImageSuffix:imageName];
    if (!suffix) {
        imageName = [NSString stringWithFormat:@"%@.png",imageName];
    }
    return imageName;
}

- (NSString*)getCacheImagePath:(NSString *)imageName
{
    if (imageName.length == 0 || !imageName)return @"";
    
    NSString * imagePath = [_imageCacheDir stringByAppendingPathComponent:imageName];
    return imagePath;
}

- (BOOL)checkImageSuffix:(NSString*)imageName
{
    if ([imageName hasSuffix:@".png"] || [imageName hasSuffix:@".jpg"]||[imageName hasSuffix:@".jpeg"])return YES;
    return NO;
}

- (UIImage*)getCacheImageWithUrl:(NSString *)url
{
    if (url.length == 0 || !url)return nil;
    
    NSString * imageName = [self getCacheImageName:url];
    NSString * imagePath = [self getCacheImagePath:imageName];
    
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

- (void)saveCacheImage:(UIImage *)image url:(NSString *)url
{
    if (url.length == 0 || !url || !image) return;
    
    NSString * imageName = [self getCacheImageName:url];
    NSString * imagePath = [self getCacheImagePath:imageName];
    
    NSLog(@"imageCache : %@",imagePath);

    NSData* imgData = UIImagePNGRepresentation(image);
    
    [PSFileManagerInStance createDirectory:_imageCacheDir];
    
    [imgData writeToFile:imagePath atomically:YES];
    
    
}
- (void)cleanImageCache
{
    [PSFileManagerInStance deleteDirectory:_imageCacheDir];
}

- (void)cleanAllImageCache
{
    [PSFileManagerInStance deleteDirectory:_imageCacheDoc];
}
@end
