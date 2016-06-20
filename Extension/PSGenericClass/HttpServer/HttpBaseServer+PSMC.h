//
//  HttpBaseServer+PSMC.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/6/20.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServer.h"

@interface HttpBaseServer (PSMC)
/**
 *  获取全部联系人
 *
 *  @param token
 *  @param block
 *
 *  @return
 */
- (BOOL)getAllMobileContactListWithToken:(NSString*)token block:(NetDictionaryResponeBlock)block;
@end
