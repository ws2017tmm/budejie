//
//  WSAllViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/5.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSAllViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "WSTopicItem.h"
#import "WSTopicFrameItem.h"
#import "WSTopicCell.h"


static NSString * const cellID = @"cellID";

@interface WSAllViewController ()

@property (strong, nonatomic) NSMutableArray *topicFrameArray;
//@property (strong, nonatomic) WSTopicCell *tempCell;

@end

@implementation WSAllViewController

//- (WSTopicCell *)tempCell {
//    if (_tempCell == nil) {
//        _tempCell = [[WSTopicCell alloc] initWithStyle:0 reuseIdentifier:cellID];
//    }
//    return _tempCell;
//}

- (NSMutableArray *)topicFrameArray {
    if (_topicFrameArray == nil) {
        _topicFrameArray = [NSMutableArray array];
    }
    return _topicFrameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // 设置tableView
    [self setupTableView];
    
    // 加载数据
    [self loadAllData];
    
    
    
    
}


/**
 设置tableView
 */
- (void)setupTableView {
    
//    self.tableView.rowHeight = 200;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:WSTopicCell.class forCellReuseIdentifier:cellID];
}

/**
 加载数据
 */
- (void)loadAllData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager ws_manager];
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(1);
    
    [mgr GET:WSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 解析数据(字典转模型)
        NSArray *tempArray = [WSTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 转换模型(提前计算frame)
        for (WSTopicItem *topicItem in tempArray) {
            WSTopicFrameItem *topicFrameItem = [[WSTopicFrameItem alloc] init];
            topicFrameItem.topicItem = topicItem;
            [self.topicFrameArray addObject:topicFrameItem];
        }
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    WSTopicFrameItem *topicFrameItem = self.topicFrameArray[indexPath.row];
    // Configure the cell...
    cell.topicFrameItem = topicFrameItem;
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSTopicFrameItem *topicFrameItem = self.topicFrameArray[indexPath.row];
    return topicFrameItem.cellHeight;
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
