//
//  WSNewViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSNewViewController.h"
#import "WSSubTagViewController.h"

@interface WSNewViewController ()

@end

@implementation WSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
}

- (void)setupNavBar {
    
    // leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 点击订阅标签调用
- (void)tagClick {
    // 进入推荐标签界面
    WSSubTagViewController *subTag = [[WSSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTag animated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
