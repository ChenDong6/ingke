//
//  CDHotViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/25.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDHotViewController.h"
#import "CDLiveHandler.h"
#import "CDLiveCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CDPlayerViewController.h"

static NSString *identifier = @"CDLiveCell";

@interface CDHotViewController ()

/**数据源*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation CDHotViewController

#pragma mark
#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CDLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //释放选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CDLive *live = self.dataList[indexPath.row];
    
    CDPlayerViewController *playerVC = [[CDPlayerViewController alloc]init];
    
    playerVC.live = live;
    [self.navigationController pushViewController:playerVC animated:YES
     ];
    
    /*
     系统自带的播放不了
    MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:live.streamAddr]];
    
    [self presentViewController:movieVC animated:YES completion:nil];
     
     */
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self loadData];
    
}

- (void)initUI {
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CDLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    
}

- (void)loadData {
    
    [CDLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        
        //给数据源赋值
        [self.dataList addObjectsFromArray:obj];
        [self.tableView reloadData];
        
    } withFailed:^(id obj) {
        NSLog(@"failed:%@",obj);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark 懒加载
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
