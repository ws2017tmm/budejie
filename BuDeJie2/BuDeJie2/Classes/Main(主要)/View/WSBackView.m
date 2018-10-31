//
//  WSBackView.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSBackView.h"

@implementation WSBackView

+ (instancetype)backViewWithTarget:(id)target selector:(SEL)sel {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
//    btn.ws_x -= 15;
    
    WSBackView *backView = [[self alloc] initWithFrame:btn.bounds];
    [backView addSubview:btn];
    return backView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
