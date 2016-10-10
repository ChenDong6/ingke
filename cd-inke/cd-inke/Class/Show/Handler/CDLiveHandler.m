//
//  CDLiveHandler.m
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDLiveHandler.h"
#import "CDHttpTool.h"
#import "CDLive.h"

@implementation CDLiveHandler

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success
                              withFailed:(FailedBlock)failed {
    
    [CDHttpTool getWithPath:API_HotLive withParams:nil withSuccess:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            failed(json);
        }
        else {
            //如果返回信息正确
            //开始数据解析
            NSArray *livesArr = [CDLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(livesArr);
        }
        
    } withFailure:^(NSError *error) {
        
        failed(error);
        
    }];
    
}

@end
