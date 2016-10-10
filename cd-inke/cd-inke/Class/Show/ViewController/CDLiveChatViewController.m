//
//  CDLiveChatViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/10/10.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDLiveChatViewController.h"

@interface CDLiveChatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *peopleCountLB;

@end

@implementation CDLiveChatViewController


- (void)setLive:(CDLive *)live {
    
    _live = live;
    
    [self.iconView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    
    __weak typeof(self)weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.peopleCountLB.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)];
        
    } repeats:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconView.layer.cornerRadius = 15;
    self.iconView.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
