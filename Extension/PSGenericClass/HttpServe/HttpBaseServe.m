//
//  HttpBaseServe.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/9.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServe.h"
@implementation HttpBaseServe
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(HttpBaseServe*)shared
{
    static HttpBaseServe * _baseService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baseService = [HttpBaseServe new];
    });
    return _baseService;
}

#pragma mark -网络基础-
- (BOOL)httpServeWithUrl:(NSString*)url param:(NSDictionary*)param  isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    if (url.length == 0 || !url) return NO;
    return  [self httpServeWithBaseUrl:APPSERVER_URL Url:url param:param isPost:isPost block:block];
}

- (BOOL)httpServeWithBaseUrl:(NSString *)baseUrl Url:(NSString *)url param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    if (baseUrl.length == 0 || !baseUrl ||  url.length == 0 || !url) return NO;
    
    if (isPost == NO) {
        [self requestWithBaseUrl:baseUrl Url:url param:param block:block];
    }
    else
    {
        [self postWithBaseUrl:baseUrl Url:url param:param block:block];
    }
    return YES;
}

- (BOOL)requestWithBaseUrl:(NSString *)baseUrl Url:(NSString*)url param:(NSDictionary*)param  block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    if (baseUrl.length == 0 || !baseUrl ||  url.length == 0 || !url) return NO;
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"URl: %@  JSON: %@",url,responseObject);
         if (block) block(responseObject, nil, nil);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error:%@",error);
         if (block) block(nil, error, nil);
     }];
    return YES;
}

- (BOOL)postWithBaseUrl:(NSString *)baseUrl Url:(NSString*)url param:(NSDictionary*)param block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    if (baseUrl.length == 0 || !baseUrl ||  url.length == 0 || !url) return NO;
    
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"URl: %@  JSON: %@",url,responseObject);
        if (block) block(responseObject, nil, nil);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error:%@",error);
        if (block) block(nil, error, nil);
    }];
    return YES;
}

#pragma mark -通用-
- (BOOL)urlGETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))success fail:(void (^)(NSString *))fail
{
    if (urlString.length == 0 || !urlString) return NO;
    
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"URl: %@  JSON: %@",urlString,responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error:%@",error);
    
    }];
    return YES;
}

- (BOOL)urlPOSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params success:(void (^)(id))success fail:(void (^)(NSString *))fail
{
    if (urlString.length == 0 || !urlString) return NO;
    
    AFHTTPSessionManager* manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSLog(@"URl: %@  JSON: %@",urlString,responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error:%@",error);
    
    }];
    return YES;
}

#pragma mark -表单-
- (BOOL)httpServeFromDataWithBaseUrl:(NSString *)baseUrl Url:(NSString *)url token:(NSString *)token param:(NSDictionary *)param block:(NetDictionaryResponeBlock)block
{
    
    if (baseUrl.length == 0 || !baseUrl ||  url.length == 0 || !url || token.length == 0 || !token) return NO;
    NSString * urlString = [NSString stringWithFormat:@"%@%@?token=%@",baseUrl,url,token];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer	= [AFHTTPResponseSerializer serializer];
    manager.completionQueue		= GCDDefaultQueue;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString * key in param.allKeys)
        {
            id value = param[key];
            
            if (IsKindOfClass(value, NSString))
            {
                NSString * str = (NSString*)value;
                [formData appendPartWithFormData:[str toData] name:key];
                continue;
            }
            if (IsKindOfClass(value, NSNumber))
            {
                NSNumber * number = (NSNumber*)value;
                [formData appendPartWithFormData:[number.stringValue toData] name:key];
                continue;
            }
            if (IsKindOfClass(value, NSData))
            {
                NSData * data = (NSData*)value;
                [formData appendPartWithFormData:data name:key];
                continue;
            }
        }
        NSLog(@"URl: %@  JSON: %@",urlString,formData);
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"URl: %@  JSON: %@",urlString,responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"URl: %@  JSON: %@",urlString,error);
        
    }];
    return YES;
}

@end
