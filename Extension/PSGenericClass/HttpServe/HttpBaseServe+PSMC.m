//
//  HttpBaseServe+PSMC.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServe+PSMC.h"

@implementation HttpBaseServe (PSMC)
- (BOOL)getAllMobileContactListWithToken:(NSString *)token block:(dictionaryBlock)block
{
    if (!token  || token.length == 0) return NO;
    
#if 1
    if (block) {
        block (@{@"code":@0});
    }
    return YES;
#endif
    
    NSDictionary * dict = @{@"token":IsSafeString(token)};
    
    [self httpServeWithUrl:@"mobileContact" param:dict isPost:NO block:^(NSDictionary *respone, NSError *error, id userParam) {
        
        if (block) {
            block(respone);
        }
    }];
    return YES;
}

/**
 *  列子参考
 */

/*
 
 //http://domain:port/esf/v2/circle/circle_list?token=&userType=2
 - (BOOL)getCircleListWithToken:(NSString *)token userType:(NSNumber *)userType block:(dictionaryBlock)block
 {
 //    if (token == nil  || token.length == 0 || !userType)return NO;
 if (!userType) return NO;
 
 NSDictionary * dict = @{@"token":IsSafeString(token),@"userType":userType};
 
 [self httpServeWithUrl:http_ModuleUrl(@"circle/circle_list") param:dict isPost:NO block:^(NSDictionary *respone, NSError *error, id userParam) {
 
 if (block) {
 block(respone);
 }
 }];
 return YES;
 }
 
 //http://domain:port/esf/v2/circle/all_posts_list?token=&pageSize=10&postsId=-1&userType=2
 - (BOOL)getUserAllPostListWithToken:(NSString *)token userType:(NSNumber *)userType postsId:(NSNumber *)postsId pagesize:(NSNumber *)pagesize block:(dictionaryBlock)block
 {
 //    if (token == nil  || token.length == 0 || !userType || !pagesize || !postsId)return NO;
 
 if (!userType || !pagesize || !postsId) return NO;
 
 NSDictionary * dict = @{@"token":IsSafeString(token),@"userType":userType,@"postsId":postsId,@"pageSize":pagesize};
 
 [self httpServeWithUrl:http_ModuleUrl(@"circle/all_posts_list") param:dict isPost:NO block:^(NSDictionary *respone, NSError *error, id userParam) {
 
 if (block) {
 block(respone);
 }
 }];
 return YES;
 }
 */

@end
