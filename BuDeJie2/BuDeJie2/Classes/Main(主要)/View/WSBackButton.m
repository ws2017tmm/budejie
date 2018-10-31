//
//  WSBackButton.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSBackButton.h"

@implementation WSBackButton

+ (WSBackButton *)backButton {
    WSBackButton *backBtn = [[self alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    
    return backBtn;
}

@end
