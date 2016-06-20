//
//  HttpBaseServer+PSMC.m
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServer+PSMC.h"

@implementation HttpBaseServer (PSMC)
- (BOOL)getAllMobileContactListWithToken:(NSString *)token block:(NetDictionaryResponeBlock)block
{
    
    if (!token  || token.length == 0) return NO;
    
#if 1
    if (block) {
        block (@{@"code":@0},nil,nil);
    }
    return YES;
#endif

    NSDictionary * dict = @{@"token":IsSafeString(token)};
    [self httpServerWithUrl:@"/contact/Mobile" param:dict isPost:NO block:block];
    
    return YES;
}
@end
