//
//  CDLaunchViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/24.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDLaunchViewController.h"

@interface CDLaunchViewController ()
- (IBAction)closeLaunch:(id)sender;

@end

@implementation CDLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeLaunch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"退出模态%s,%d",__func__,__LINE__);
    }];
    
}
@end
