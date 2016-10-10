//
//  CDLiveHandler.h
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDBaseHandler.h"

@interface CDLiveHandler : CDBaseHandler
/**
 *  获取热门直播信息
 *
 *  @param success
 *  @param failed  
 */
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success
                              withFailed:(FailedBlock)failed;


@end
