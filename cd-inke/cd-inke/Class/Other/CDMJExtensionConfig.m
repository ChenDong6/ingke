//
//  CDMJExtensionConfig.m
//  cd-inke
//
//  Created by ChenDong on 16/9/27.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDMJExtensionConfig.h"
#import "CDLive.h"
#import "CDCreator.h"

@implementation CDMJExtensionConfig

+ (void)load {
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"idField" : @"id"
                 };
    }];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"descriptionField" : @"description"
                 };
    }];
    
    
    //驼峰转下划线去取值
    [CDLive mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [CDCreator mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
}


@end
