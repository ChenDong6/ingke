//
//  CDHttpTool.h
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpSuccessBlock)(id json);
typedef void(^HttpFailureBlock)(NSError *error);
typedef void(^HttpDownloadProgressBlock)(CGFloat progress);
typedef void(^HttpUploadProgressBlock)(CGFloat progress);

@interface CDHttpTool : NSObject

/**
 *  get网络请求
 *
 *  @param path     url地址
 *  @param params   url参数   NSDictionary类型
 *  @param success  请求成功   返回NSDictionary或NSArray
 *  @param failure  请求失败   返回NSError
 */
+ (void)getWithPath:(NSString *)path
             withParams:(NSDictionary *)params
            withSuccess:(HttpSuccessBlock)success
            withFailure:(HttpFailureBlock)failure;

/**
 *  post网络请求
 *
 *  @param path     url地址
 *  @param params   url参数   NSDictionary类型
 *  @param success  请求成功   返回NSDictionary或NSArray
 *  @param failure  请求失败   返回NSError
 */+ (void)postWithPath:(NSString *)path
         withParams:(NSDictionary *)params
        withSuccess:(HttpSuccessBlock)success
        withFailure:(HttpFailureBlock)failure;

/**
 *  下载文件
 *
 *  @param path     url地址
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path
             withSuccess:(HttpSuccessBlock)success
             withFailure:(HttpFailureBlock)failure
            withProgress:(HttpDownloadProgressBlock)progress;

/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param params   上传参数
 *  @param thumName imageKey
 *  @param image    UIImage对象
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadWithPath:(NSString *)path
            withParams:(NSDictionary *)params
          withThumName:(NSString *)imageKey
             withImage:(UIImage *)image
           withSuccess:(HttpSuccessBlock)success
           withFailure:(HttpFailureBlock)failure
          withProgress:(HttpUploadProgressBlock)progress;


@end
