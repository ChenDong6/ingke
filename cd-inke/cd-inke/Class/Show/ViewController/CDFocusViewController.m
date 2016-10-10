//
//  CDFocusViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/25.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDFocusViewController.h"

@interface CDFocusViewController ()

@end

@implementation CDFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 200)];
    label.text = @"我是第一个界面";
    label.font = [UIFont systemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
