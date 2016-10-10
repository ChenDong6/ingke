//
//  CDMainTopView.m
//  cd-inke
//
//  Created by ChenDong on 16/9/25.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import "CDMainTopView.h"

@interface CDMainTopView ()

/**按钮下白线*/
@property (nonatomic, strong) UIView *lineView;

/**存储按钮*/
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation CDMainTopView


- (instancetype)initWithFrame:(CGRect)frame withTitleNames:(NSArray *)titleNames
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //按钮的宽高
        CGFloat btnWidth = self.width / titleNames.count;
        CGFloat btnHeight = self.height;
        
        //循环创建按钮
        for (NSInteger i = 0; i < titleNames.count; i ++) {
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //设置标题
            [titleBtn setTitle:titleNames[i] forState:UIControlStateNormal];
            //设置字体颜色
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //设置字体大小
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            
            //设置frame
            [titleBtn setFrame:CGRectMake(i * btnWidth, 0, btnWidth, btnHeight)];
            
            //设置tag值
            titleBtn.tag = i;
            
            //添加监听事件
            [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //将按钮存入数组
            [self.buttons addObject:titleBtn];
            
            [self addSubview:titleBtn];
            
            //创建按钮下白线
            if (i == 1) {
                //白线的
//                CGFloat lineHeight = 2;
//                CGFloat lineY = 40;
                
//                self.lineView = [[UIView alloc]init];
//                self.lineView.backgroundColor = [UIColor whiteColor];
                //自适应最佳size
                [titleBtn.titleLabel sizeToFit];
                
//                self.lineView.height = lineHeight;
//                self.lineView.top = lineY;
                self.lineView.width = titleBtn.titleLabel.width;
                self.lineView.centerX = titleBtn.centerX;
                
                [self addSubview:self.lineView];
                
            }
            
            
        }
        
    }
    return self;
}
//mainVC滚动时调用
- (void)scrollingLineView:(NSInteger)index{
    
    UIButton *btn = self.buttons[index];
    @weakify(self);
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);
        self.lineView.centerX = btn.centerX;
    }];
}

- (void)titleBtnClick:(UIButton *)btn {
    
    if (self.topViewBlock) {
        self.topViewBlock(btn.tag);
    }
    
    [self scrollingLineView:btn.tag];
}

#pragma mark
#pragma mark 懒加载
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.height = 2;
        _lineView.top = 40;
    }
    return _lineView;
}

- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}



@end
