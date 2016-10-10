//
//  CDBaseHandler.h
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *处理完成事件
 */
typedef void(^CompleteBlock)();

/**
 *  处理事件成功
 *
 *  @param   obj  返回数据
 */
typedef void(^SuccessBlock)(id obj);

/**
 *  处理事件失败
 *
 *  @param  obj 错误信息
 */
typedef void(^FailedBlock)(id obj);


@interface CDBaseHandler : NSObject

@end
