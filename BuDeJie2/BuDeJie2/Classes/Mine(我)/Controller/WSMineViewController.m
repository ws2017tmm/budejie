//
//  WSMineViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSMineViewController.h"
#import "WSSettingViewController.h"

@interface WSMineViewController ()

@end

@implementation WSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    
    [self setupNavBar];
    
}

- (void)setupNavBar {
    
    self.navigationItem.title = @"我的";
    
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    
}

#pragma mark - 导航栏上的item点击事件
- (void)night:(UIButton *)button {
    button.selected = !button.selected;
    
}

- (void)setting {
    // 跳转到设置界面
    WSSettingViewController *settingVc = [[WSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
