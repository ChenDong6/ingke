//
//  CDMainViewController.m
//  cd-inke
//
//  Created by ChenDong on 16/9/23.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDMainViewController.h"
#import "CDMainTopView.h"

@interface CDMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

/**数据源*/
@property (nonatomic, strong) NSArray *dataList;

/**顶部按钮*/
@property (nonatomic, strong) CDMainTopView *topView;


@end

@implementation CDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载UI
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark  自定义方法
- (void)initUI {
    
    //添加左右按钮
    [self setupNavItem];
    
    //添加子视图控制器
    [self setupChildViewControllers];
    
}

- (void)setupNavItem {
    
    //设置头视图
    self.navigationItem.titleView = self.topView;
    
    //添加navigation的左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"global_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:nil action:nil];
    //添加navigation的右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)setupChildViewControllers {
    //添加子控件
    NSArray *vcNames = @[@"CDFocusViewController",@"CDHotViewController",@"CDNearViewController"];
    
    for (int i = 0; i < vcNames.count; i++) {
        //取出类名
        NSString *vcName = vcNames[i];
        //使用父类动态创建子类
        UIViewController *VC = [[NSClassFromString(vcName) alloc]init];
        //添加控制器的名称
        VC.title = self.dataList[i];
        //添加子视图控制器
        [self addChildViewController:VC];
    }
    
    //将自控制器的view添加到MainVC的scrollView上
    
    //设置scrollView的contenSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    
    //默认先展示第二个界面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    //进入时加载界面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

#pragma mark
#pragma mark UIScrollViewDelegate
//动画结束时调用的代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //每个view的宽和高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    //获取scrollView的contenOffset
    CGFloat offset = scrollView.contentOffset.x;
    
    //获取页面的索引值
    NSInteger index = offset / width;
    
    //使lineView联动
    [self.topView scrollingLineView:index];
    
    //根据索引值获取VC的引用
    UIViewController *VC = self.childViewControllers[index];

    //判断VC是否已经加载(VC是否执行viewDidLoad) 如果执行就返回
    if ([VC isViewLoaded]) return;
    
    //如果没有执行VC，则设置VC的frame
    VC.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    
    //将自控制器VC的view添加到scrollView上
    [scrollView addSubview:VC.view];
}
//减速结束时调用加载自控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
//    //每个view的宽和高
//    CGFloat width = SCREEN_WIDTH;
//    CGFloat height = SCREEN_HEIGHT;
//    
//    //获取scrollView的contenOffset
//    CGFloat offset = scrollView.contentOffset.x;
//    
//    //获取页面的索引值
//    NSInteger index = offset / width;
//    
//    //根据索引值获取VC的引用
//    UIViewController *VC = self.childViewControllers[index];
//    
//    //判断VC是否已经加载(VC是否执行viewDidLoad) 如果执行就返回
//    if ([VC isViewLoaded]) return;
//    
//    //如果没有执行VC，则设置VC的frame
//    VC.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
//    
//    //将自控制器VC的view添加到scrollView上
//    [scrollView addSubview:VC.view];
}

#pragma mark
#pragma mark 懒加载
- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    return _dataList;
}

- (CDMainTopView *)topView {
    if (!_topView) {
        _topView = [[CDMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) withTitleNames:self.dataList];
//        __weak typeof(self)weakSelf = self;
        @weakify(self);
        //实现block
        _topView.topViewBlock = ^(NSInteger tag){
            @strongify(self);
//            __strong typeof(self)strongSelf = self;
            CGPoint offset = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:offset animated:YES];
            
            
        };
    }
    return _topView;
}

@end
