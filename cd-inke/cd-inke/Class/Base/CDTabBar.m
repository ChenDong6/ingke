//
//  CDTabBar.m
//  cd-inke
//
//  Created by ChenDong on 16/9/22.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDTabBar.h"

@interface CDTabBar ()
/**
 tabbar的背景view
 */
@property (nonatomic, strong) UIImageView *tabBarbgView;

/**数据源*/
@property (nonatomic, strong) NSArray *dataList;

/**记录上一个选中的item*/
@property (nonatomic, strong) UIButton *lastItem;

/**相机按钮*/
@property (nonatomic, strong) UIButton *cameraButton;

@end

@implementation CDTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载背景图片
        [self addSubview:self.tabBarbgView];
        
        //装载item
        for (NSUInteger i = 0; i < self.dataList.count; i++) {
            
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            //不让图片在高亮下改变
            item.adjustsImageWhenHighlighted = NO;
            
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = CDItemTypeLive + i;
            
            if (i == 0) {
                item.selected = YES;
                //初始化
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        
        //添加相机按钮
        [self addSubview:self.cameraButton];
        
        
        
    }
    return self;
}
//加载子视图的时候调用（加载item的frame）
- (void)layoutSubviews{
    [super layoutSubviews];
    //背景图片的frame
    self.tabBarbgView.frame = self.bounds;
    
    //每个item的宽度
    CGFloat width = self.bounds.size.width / self.dataList.count;
    
    for (NSUInteger i = 0; i < [self subviews].count; i++) {
        
        UIView *btn = [self subviews][i];
        
        //判断是否为UIbutton类型
        if ([btn isKindOfClass:[UIButton class]]) {
            
            [btn setFrame:CGRectMake((btn.tag - CDItemTypeLive) * width, 0, width, self.frame.size.height)];
        }
    }
    
    //设置相机按钮的位置
    //根据内容自适应宽高
    [self.cameraButton sizeToFit];
    
    self.cameraButton.center = CGPointMake(self.center.x, self.bounds.size.height - 50);
}

#pragma mark
#pragma mark 自定义方法
- (void)clickItem:(UIButton *)button{
    
    //代理方法
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:button.tag];
    }
    
    //block方法一
    if (self.block) {
        self.block(self,button.tag);
    }
    
    //block写法二
    !self.block?:self.block(self,button.tag);

    if (button.tag == CDItemTypeLaunch) {
        return;
    }
    
    //设置按钮状态
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //设置按钮动画
    [UIView animateWithDuration:0.2 animations:^{
        //扩大1.2倍数
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            //恢复原始状态
            button.transform = CGAffineTransformIdentity;
        }];
    }];
    
}


#pragma mark
#pragma mark attribute
- (UIImageView *)tabBarbgView{
    if (!_tabBarbgView) {
        _tabBarbgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBarbgView;
}

- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

- (UIButton *)cameraButton{
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        
        _cameraButton.tag = CDItemTypeLaunch;
        
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}


@end
