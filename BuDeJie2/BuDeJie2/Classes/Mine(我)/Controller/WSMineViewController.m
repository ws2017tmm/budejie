//
//  WSMineViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSMineViewController.h"
#import "WSSettingViewController.h"
#import "WSSquareCell.h"
#import "WSSquareItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SafariServices/SafariServices.h>

@interface WSMineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SFSafariViewControllerDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *squareItems;

@end

@implementation WSMineViewController

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (WSScreenW - (cols - 1) * margin) / cols


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置导航栏
    [self setupNavBar];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置tableview的footview
    [self setupFootView];
    
    // 请求数据
    [self loadData];
}

#pragma mark - 初始化
/**
 设置导航栏
 */
- (void)setupNavBar {
    self.navigationItem.title = @"我的";
    
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
}

- (void)setupTableView {
    // 处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = WSMarin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(WSMarin - 35, 0, 0, 0);
}

/**
 设置tableView底部视图
 */
- (void)setupFootView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.minimumLineSpacing = margin;
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(WSSquareCell.class) bundle:nil] forCellWithReuseIdentifier:ID];
    
    self.collectionView = collectionView;
    self.tableView.tableFooterView = collectionView;
    
}

#pragma mark - 网络请求数据
- (void)loadData {
    // 1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ws_manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [manager GET:WSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/lixiang041/Desktop/plist/square.plist" atomically:YES];
        
        self.squareItems = [WSSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        // 处理数据
        [self resloveData];
        
        // 计算collectioView的高度
        NSUInteger count = self.squareItems.count;
        // 有多少行(万能公式)
        NSUInteger row = (count - 1) / cols + 1;
        self.collectionView.ws_height = row * (itemWH + 1);
        // 重新设置tableView 滚动范围:自己计算
        self.tableView.tableFooterView = self.collectionView;
        
        // 刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}

#pragma mark - 处理请求完成数据
- (void)resloveData {
    // 不正确的数据去掉
    for (WSSquareItem *item in self.squareItems) {
        if (![item isKindOfClass:WSSquareItem.class]) {
            [self.squareItems removeObject:item];
        }
    }
    
    // 缺几个
    NSUInteger count = self.squareItems.count;
    NSUInteger extra = count % cols;
    if (extra != 0) {
        extra = cols - extra;
        for (int i = 0; i < extra; i++) {
            WSSquareItem *item = [[WSSquareItem alloc] init];
            [self.squareItems addObject:item];
        }
    }
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


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 从缓存池取
    WSSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.squareItem = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建网页控制器
    WSSquareItem *item = self.squareItems[indexPath.item];
    if (![item.url containsString:@"http"]) return;
    
    SFSafariViewControllerConfiguration *configuration = [[SFSafariViewControllerConfiguration alloc] init];
    configuration.entersReaderIfAvailable = YES;
    // 默认是yes
    configuration.barCollapsingEnabled = YES;
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url] configuration:configuration];
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]];
    safariVC.delegate = self;
    safariVC.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
    [self presentViewController:safariVC animated:YES completion:nil];
}




- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
//    WSFunc
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
//    WSFunc
}

- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL API_AVAILABLE(ios(11.0)) {
    NSLog(@"URL = %@",URL);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
