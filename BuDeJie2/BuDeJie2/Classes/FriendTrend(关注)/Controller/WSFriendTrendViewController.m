//
//  WSFriendTrendViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSFriendTrendViewController.h"
#import "WSFriendTrendNoLoginView.h"
#import "WSLoginRegisterViewController.h"

#define isUserLogined NO

@interface WSFriendTrendViewController ()

@property (weak, nonatomic) WSFriendTrendNoLoginView *noLoginView;

@end

@implementation WSFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    
    // titleView
    self.navigationItem.title = @"我的关注";
    
    // 判断用户是否登录显示不同的界面
    [self judgeUserLogin];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    
}

#pragma mark - 判断用户是否登录
- (void)judgeUserLogin {
    if (isUserLogined) { // 已登录
        if (self.noLoginView) {
            [self.noLoginView removeFromSuperview];
        }
        // 添加登录后的view
        
    } else {
        WSFriendTrendNoLoginView *view = [WSFriendTrendNoLoginView loadFormXib];
        view.registerLoginBtnClick = ^{
            WSLoginRegisterViewController *VC = [[WSLoginRegisterViewController alloc] init];
            [self presentViewController:VC animated:YES completion:nil];
        };
        self.noLoginView = view;
        view.frame = self.view.bounds;
        [self.view addSubview:view];
        
//        NSLog(@"----%@",NSStringFromCGRect(self.view.bounds));
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    NSLog(@"----%@",NSStringFromCGRect(self.view.bounds));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
