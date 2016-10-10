//
//  CDHttpTool.m
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDHttpTool.h"
#import "AFNetworking/AFnetworking.h"

//baseUrl
static NSString *kBaseUrl = SERVERS_HOST;

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        
        //接收参数类型
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"image/gif", nil];
        
        //设置超时时间
        client.requestSerializer.timeoutInterval = 15;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
}

@end


@implementation CDHttpTool

+ (void)getWithPath:(NSString *)path
         withParams:(NSDictionary *)params
        withSuccess:(HttpSuccessBlock)success
        withFailure:(HttpFailureBlock)failure {
    
    //获取完整的URL路径
    NSString *urlString = [kBaseUrl stringByAppendingString:path];
    
    [[AFHttpClient sharedClient] GET:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)postWithPath:(NSString *)path
          withParams:(NSDictionary *)params
         withSuccess:(HttpSuccessBlock)success
         withFailure:(HttpFailureBlock)failure {
    
    //获取完整的url路径
    NSString *urlString = [kBaseUrl stringByAppendingString:path];
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)downloadWithPath:(NSString *)path
             withSuccess:(HttpSuccessBlock)success
             withFailure:(HttpFailureBlock)failure
            withProgress:(HttpDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString *urlString = [kBaseUrl stringByAppendingString:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //获取沙盒cache路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }
        else{
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}

+ (void)uploadWithPath:(NSString *)path
            withParams:(NSDictionary *)params
          withThumName:(NSString *)imageKey
             withImage:(UIImage *)image
           withSuccess:(HttpSuccessBlock)success
           withFailure:(HttpFailureBlock)failure
          withProgress:(HttpUploadProgressBlock)progress {
    
    //获取完整路劲
    NSString *urlString = [kBaseUrl stringByAppendingString:path];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}



@end
