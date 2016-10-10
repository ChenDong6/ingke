//
//  CDTabBar.h
//  cd-inke
//
//  Created by ChenDong on 16/9/22.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDTabBar;

/**
定义选择按钮的枚举
 */
typedef NS_ENUM(NSUInteger, CDItemType) {
    CDItemTypeLaunch = 10, //启动直播
    CDItemTypeLive = 100, //展示直播
    CDItemTypeMe, //我的
};

/**
 tabbar的block
 */
typedef void(^CDTabBarBlock)(CDTabBar *,CDItemType);



/**
 自定义tabbar的代理
 */
@protocol CDTabBarDelegate <NSObject>

/**
 自定义tabbar代理方法
 */
- (void)tabbar:(CDTabBar *)tabbar clickButton:(CDItemType)index;

@end

@interface CDTabBar : UIView


/**代理属性*/
@property (nonatomic, weak) id<CDTabBarDelegate> delegate;

/**block属性*/
@property (nonatomic, copy)  CDTabBarBlock block;


@end
