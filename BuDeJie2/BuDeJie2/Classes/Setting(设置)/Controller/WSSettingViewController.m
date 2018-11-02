//
//  WSSettingViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSSettingViewController.h"
#import "WSFileTool.h"


#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface WSSettingViewController ()

@property (assign, nonatomic) unsigned long long totalSize;

@end

@implementation WSSettingViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    _totalSize = [WSFileTool getDirectorySize:CachePath];
    
}

// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    return sizeStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 获取缓存尺寸字符串
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 删除文件夹里面所有文件
    if (indexPath.row == 0) {
        [WSFileTool removeDirectoryPath:CachePath];
        _totalSize = 0;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




@end
