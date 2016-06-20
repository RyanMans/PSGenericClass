//
//  HttpBaseServer.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServer.h"
@interface HttpBaseServer ()
@property (nonatomic,copy)NSString * appDomianUrl;
@property (nonatomic,copy)NSString * elearnDomianUrl;
@property (nonatomic,copy)NSString * baseApiUrl;
@property (nonatomic,copy)NSString * baseElearnUrl;
@end

@implementation HttpBaseServer
+ (HttpBaseServer*)shared
{
    static HttpBaseServer * _baseServer = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _baseServer = [[HttpBaseServer alloc] init];
    });
    
    return _baseServer;
}
- (NSString*)appDomianUrl
{
    return EJY_AppServer_Url;
}
- (NSString*)elearnDomianUrl
{
    return EJY_Elearning_Url;
}
- (NSString*)baseApiUrl
{
    return [NSString stringWithFormat:@"%@/%@",self.appDomianUrl,EJY_SERVER_VERSION];
}
- (NSString*)baseElearnUrl
{
    return [NSString stringWithFormat:@"%@/%@",self.elearnDomianUrl,EJY_ELEARN_VERSION];
}
#pragma mark - Base -
- (BOOL)urlGETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(NetDictionaryResponeBlock)block
{
    if (urlString.length == 0 || !urlString) return NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer	= [AFHTTPResponseSerializer serializer];
    manager.completionQueue		= GCDDefaultQueue;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    WeakSelf(ws);
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (block)
        {
            NSDictionary * response = [ws toDictionaryWithJSON:responseObject];
            block(response,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil,error,nil);
        }
    }];
    
    return YES;
}

- (BOOL)urlPOSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params  block:(NetDictionaryResponeBlock)block
{
    
    if (urlString.length == 0 || !urlString) return NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer	= [AFHTTPResponseSerializer serializer];
    manager.completionQueue		= GCDDefaultQueue;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    WeakSelf(ws);
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation * operation, id responseObject) {
        if (block)
        {
            NSDictionary *respone = [ws toDictionaryWithJSON:responseObject];
            block(respone, nil, nil);
        }
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        if (block)
        {
            block(nil, error, nil);
        }
    }];
    return YES;
}
#pragma mark - Net Method -
- (BOOL)httpServerWithUrl:(NSString *)url param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    
    if (url.length == 0 || !url) return NO;
    return [self httpServerWithBaseUrl:self.baseApiUrl path:url param:param isPost:isPost block:block];
}

- (BOOL)httpElearningServerWithUrl:(NSString *)url param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block

{
    LogFunctionName();
    if (url.length == 0 || !url) return NO;
    return [self httpServerWithBaseUrl:self.baseElearnUrl path:url param:param isPost:isPost block:block];
}

- (BOOL)httpServerWithBaseUrl:(NSString *)baseUrl path:(NSString *)path param:(NSDictionary *)param isPost:(BOOL)isPost block:(NetDictionaryResponeBlock)block
{
    LogFunctionName();
    
    if (baseUrl.length == 0 || !baseUrl || path.length == 0 || !path) return NO;

    NSString * urlString = [NSString stringWithFormat:@"%@%@",baseUrl,path];
    if (isPost == NO)
    {
        return [self urlGETRequestWithUrl:urlString params:param block:block];
    }
    return [self urlPOSTRequestWithUrl:urlString params:param block:block];
}

@end
