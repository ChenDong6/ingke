//
//  CDPlayerViewController.h
//  cd-inke
//
//  Created by ChenDong on 16/9/28.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDBaseViewController.h"
#import "CDLive.h"

@interface CDPlayerViewController : CDBaseViewController

/**直播数据模型*/
@property (nonatomic, strong) CDLive *live;

@end
