//
//  WSSettingViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSSettingViewController.h"
#import "WSFileTool.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface WSSettingViewController ()

@property (strong, nonatomic) NSString *totalSizeStr;

@end

@implementation WSSettingViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
    [WSFileTool getDirectorySizeStr:CachePath completion:^(NSString * _Nonnull sizeStr) {
        [SVProgressHUD dismiss];
        self.totalSizeStr = sizeStr;
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 获取缓存尺寸字符串
    cell.textLabel.text = self.totalSizeStr;
    
    return cell;
}

// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 删除文件夹里面所有文件
    if (indexPath.row == 0) {
        [WSFileTool removeDirectoryPath:CachePath];
        _totalSizeStr = @"清除缓存";
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




@end
