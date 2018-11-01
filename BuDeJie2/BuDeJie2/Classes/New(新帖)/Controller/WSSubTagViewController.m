//
//  WSSubTagViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/10/31.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSSubTagViewController.h"
#import "AFHTTPSessionManager+manager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "WSSubTagItem.h"
#import "WSSubTagCell.h"

@interface WSSubTagViewController ()

@property (nonatomic, strong) NSArray *subTags;
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation WSSubTagViewController

static NSString * const cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    // 设置tableView的一些属性
    [self setupTableView];
    
    // 请求数据
    [self loadData];
    
    
}

#pragma mark - setupTableView
- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 220 220 221
    self.tableView.backgroundColor = WSColor(220, 220, 221);
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(WSSubTagCell.class) bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 销毁指示器
    [SVProgressHUD dismiss];
    
    // 停止任务
    if (self.manager.tasks.count > 0) {
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}

- (void)loadData {
    
    // 提示用户当前正在加载数据 SVPro
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ws_manager];
    self.manager = manager;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [manager GET:WSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        // 解析数据
        self.subTags = [WSSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

#pragma mark - Table view dategate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.subTagItem = self.subTags[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
