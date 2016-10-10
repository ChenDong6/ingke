//
//  CDMainTopView.h
//  cd-inke
//
//  Created by ChenDong on 16/9/25.
//  Copyright © 2016年 ChenDong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopViewBlock)(NSInteger tag);



@interface CDMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitleNames:(NSArray *)titleNames;

/**block*/
@property (nonatomic, copy) MainTopViewBlock topViewBlock;

/**
 lineView和scrollView联动
 */
- (void)scrollingLineView:(NSInteger)index;

@end
