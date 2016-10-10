//
//  CDTabBarViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/22.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDTabBarViewController.h"
#import "CDTabBar.h"
#import "CDBaseNavigationViewController.h"
#import "CDLaunchViewController.h"


@interface CDTabBarViewController ()<CDTabBarDelegate>

/**自定义的tabbar*/
@property (nonatomic, strong) CDTabBar *cdTabBar;

@end

@implementation CDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载控制器
    [self configViewControllers];
    
    //加载tabBar
    [self.tabBar addSubview:self.cdTabBar];
    
    //去除tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

#pragma mark
#pragma mark 自定义方法
//加载控制器
- (void)configViewControllers{
    
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:@[@"CDMainViewController",@"CDMeViewController"]];
    
    for (NSUInteger i = 0; i < mArray.count; i++) {
        NSString *vcName = mArray[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        
        CDBaseNavigationViewController *nav = [[CDBaseNavigationViewController alloc]initWithRootViewController:vc];
        
        [mArray replaceObjectAtIndex:i withObject:nav];
        
//        [self addChildViewController:nav];
    }
    
    self.viewControllers = mArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark tabBarDelegate
- (void)tabbar:(CDTabBar *)tabbar clickButton:(CDItemType)index{
    
    if (index != CDItemTypeLaunch) {
        self.selectedIndex = index - CDItemTypeLive;
        return;
    }
    
    CDLaunchViewController *launchVC = [[CDLaunchViewController alloc]init];
    
    [self presentViewController:launchVC animated:YES completion:^{
        NSLog(@"launchVC模态完成 %s,%d",__func__,__LINE__);
    }];
    
    
    
}

#pragma mark
#pragma mark 懒加载
- (CDTabBar *)cdTabBar{
    if (!_cdTabBar) {
        _cdTabBar = [[CDTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        
        _cdTabBar.delegate = self;
    }
    return _cdTabBar;
}

@end
