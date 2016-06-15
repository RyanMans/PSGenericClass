//
//  HttpBaseServe+PSMC.h
//  PSGenericClass
//
//  Created by Ryan_Man on 16/5/11.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "HttpBaseServe.h"

@interface HttpBaseServe (PSMC)
/**
 *  获取全部联系人
 *
 *  @param token
 *  @param block
 *
 *  @return
 */
- (BOOL)getAllMobileContactListWithToken:(NSString*)token block:(dictionaryBlock)block;
@end
