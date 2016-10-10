//
//  CDBaseNavigationViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/23.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDBaseNavigationViewController.h"

@interface CDBaseNavigationViewController ()

@end

@implementation CDBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationBar的颜色
    self.navigationBar.barTintColor = RGB(0, 216, 201);
    //改变item的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count) {
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
}


@end
