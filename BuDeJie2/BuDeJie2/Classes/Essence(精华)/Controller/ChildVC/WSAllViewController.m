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
#import <MJRefresh.h>

#define WSEssencePlistPath [WSCachePath stringByAppendingPathComponent:@"essence.plist"]

static NSString * const cellID = @"cellID";

@interface WSAllViewController ()

@property (strong, nonatomic) NSMutableArray *topicFrameArray;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation WSAllViewController

- (NSMutableArray *)topicFrameArray {
    if (_topicFrameArray == nil) {
        _topicFrameArray = [NSMutableArray array];
    }
    return _topicFrameArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager ws_manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // 设置tableView
    [self setupTableView];
    
    // 添加上下拉刷新
    [self setupRefresh];
    
    // 本地加载数据(预先展示，防止网络不好，空数据)
//    [self loadAllDataFromLocal];
    
    
    // 网络请求数据
    [self loadAllDataFromNetwork];
    
    
}

#pragma mark - 设置界面
/**
 设置tableView
 */
- (void)setupTableView {
    
    [self.tableView registerClass:WSTopicCell.class forCellReuseIdentifier:cellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.lightGrayColor;
}

- (void)setupRefresh {
    __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 滚动指示器的内边距和tableView一致
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 网络请求数据
/**
 第一次加载网络数据
 */
- (void)loadAllDataFromNetwork {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager ws_manager];
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(1);
    
    [mgr GET:WSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        // 缓存plist
//        @synchronized (self) {
//            [responseObject writeToFile:WSEssencePlistPath atomically:YES];
//        }
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 解析数据(字典转模型)
        NSArray *tempArray = [WSTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 转换模型(提前计算frame)
        [self topicFrameArrWithTopic:tempArray];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
    }];
}

/**
 下拉刷新数据
 */
- (void)loadNewData {
    // 1.取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(1);
    parameters[@"maxtime"] = self.maxtime;
    
    // 3.发送请求
    [self.manager GET:WSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数据
        NSArray *tempArray = [WSTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 转换模型(提前计算frame)
        [self topicFrameArrWithTopic:tempArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
  模型转换成topicFrameItem 的数组

 @param topicItemArray 传入topicItem模型的数组
 */
- (void)topicFrameArrWithTopic:(NSArray *)topicItemArray {
    for (WSTopicItem *topicItem in topicItemArray) {
        WSTopicFrameItem *topicFrameItem = [[WSTopicFrameItem alloc] init];
        topicFrameItem.topicItem = topicItem;
        [self.topicFrameArray addObject:topicFrameItem];
    }
}

/**
 本地加载数据
 */
- (void)loadAllDataFromLocal1 {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:WSEssencePlistPath];
    NSArray *tempArray = [WSTopicItem mj_objectArrayWithKeyValuesArray:dict[@"list"]];
    // 转换模型(提前计算frame)
    for (WSTopicItem *topicItem in tempArray) {
        WSTopicFrameItem *topicFrameItem = [[WSTopicFrameItem alloc] init];
        topicFrameItem.topicItem = topicItem;
        [self.topicFrameArray addObject:topicFrameItem];
    }
    [self.tableView reloadData];
}

- (void)loadAllDataFromLocal {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 先从本地plist里尝试加载数据(展示最后一次刷新的数据)
        //从文件当中读取字典, 保存的plist文件就是一个字典,这里直接填写plist文件所存的路径
        NSMutableDictionary *dict;
        @synchronized (self) {
            dict = [NSMutableDictionary dictionaryWithContentsOfFile:WSEssencePlistPath];
        }
        // 解析数据(字典转模型)
        NSArray *tempArray = [WSTopicItem mj_objectArrayWithKeyValuesArray:dict[@"list"]];
        
        // 转换模型(提前计算frame)
        for (WSTopicItem *topicItem in tempArray) {
            WSTopicFrameItem *topicFrameItem = [[WSTopicFrameItem alloc] init];
            topicFrameItem.topicItem = topicItem;
            [self.topicFrameArray addObject:topicFrameItem];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 刷新数据
            [self.tableView reloadData];
        });
    });
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
    
//    NSLog(@"--------cellForRowAtIndexPath");
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static int i = 0;
    NSLog(@"----%d",i);
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
