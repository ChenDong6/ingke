//
//  CDAPIConfig.h
//  cd-inke
//
//  Created by ChenDong on 16/9/26.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDAPIConfig : NSObject

//信息类服务器地址
#define SERVERS_HOST @"http://service.ingkee.com/"

//图片服务器地址
#define IMAGE_HOST @"http://img.meelive.cn/"

//热门直播
#define API_HotLive @"api/live/gettop"

//附近的人
#define API_NearLive @"api/live/near_recommend" //?uid=8514989&latitude=40.090562&longitude=116.413353

//广告服务器地址
#define API_Advertise @"advertise/get"

//


@end
