//
//  WSLoginRegisterViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/1.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSLoginRegisterViewController.h"
#import "WSRegisterLoginView.h"
#import "WSLoginTextField.h"
#import "UITextField+placeholder.h"

@interface WSLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeading;

@end

@implementation WSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建登录view
    WSRegisterLoginView *loginView = [WSRegisterLoginView loginView];
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    
    // 添加注册界面
    WSRegisterLoginView *registerView = [WSRegisterLoginView registerView];
    // 添加到中间的view
    [self.middleView addSubview:registerView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    WSRegisterLoginView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.ws_width * 0.5, self.middleView.ws_height);
    
    // 设置注册view
    WSRegisterLoginView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.ws_width * 0.5, 0,self.middleView.ws_width * 0.5, self.middleView.ws_height);
    
    
}

#pragma mark - 按钮的点击事件
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerBtnClicked:(UIButton *)button {
    button.selected = !button.selected;
    
    // 更改约束
    if (button.isSelected) {
        self.middleViewLeading.constant = -(self.middleView.ws_width * 0.5);
    } else {
        self.middleViewLeading.constant = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
