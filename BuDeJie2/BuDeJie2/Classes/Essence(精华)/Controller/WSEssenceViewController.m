//
//  WSEssenceViewController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSEssenceViewController.h"
#import "WSAllViewController.h"
#import "WSVideoViewController.h"
#import "WSPictureViewController.h"
#import "WSVoiceViewController.h"
#import "WSWordViewController.h"

#define WSTopTitleViewH 35
static NSString * const ID = @"ID";


@interface WSEssenceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 顶部标题view */
@property (weak, nonatomic) UIScrollView *topTilteScrollView;
/** 内容view */
@property (weak, nonatomic) UICollectionView *contentCollectionView;
/** 内容view当前的偏移量 */
@property (assign, nonatomic) CGFloat collectionViewCurrentOffsetX;
/** 顶部标题按钮数组 */
@property (strong, nonatomic, nullable) NSMutableArray *topTitleBtnList;
/** 当前选中的按钮 */
@property (weak, nonatomic) UIButton *selectedBtn;
/** 是否点击了按钮 */
@property (assign, nonatomic, getter=isSelectedButton) BOOL selectedButton;
/** 顶部标题按钮的宽度 */
@property (assign, nonatomic) CGFloat topTitleBtnWidth;
/** 当前选中按钮的下划线 */
@property (weak, nonatomic) UIView *underLine;

@end

@implementation WSEssenceViewController

- (NSMutableArray *)topTitleBtnList {
    if (_topTitleBtnList == nil) {
        _topTitleBtnList = [NSMutableArray array];
    }
    return _topTitleBtnList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavBar];
    
    // 设置所有的子控制器
    [self setupAllChildVC];
    
    // 设置contentView（collectionView）
    [self setupCollectionView];
    
    // 设置顶部标题view(scrollview)
    [self setupTopTitleView];
    
    // 设置顶部标题按钮
    [self setupTopTitleButtons];
    
}

#pragma mark - 设置UI
/**
 设置导航条
 */
- (void)setupNavBar {
    
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

/**
 设置所有的子控制器
 */
- (void)setupAllChildVC {
    // 全部
    WSAllViewController *allVC = [[WSAllViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    // 视频
    WSVideoViewController *videoVC = [[WSVideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    // 图片
    WSPictureViewController *pictureVC = [[WSPictureViewController alloc] init];
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    
    // 声音
    WSVoiceViewController *voiceVC = [[WSVoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    // 段子
    WSWordViewController *wordVC = [[WSWordViewController alloc] init];
    wordVC.title = @"段子";
    [self addChildViewController:wordVC];
}

/**
 设置contentView（collectionView
 */
- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = WSScreenSize;
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:WSScreenBounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = UIColor.lightGrayColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:ID];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    _contentCollectionView = collectionView;
    
    // 取消自动内边距
    if (@available(iOS 11.0,*)) {
        self.contentCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

/**
 设置顶部标题view
 */
- (void)setupTopTitleView {
    CGFloat y = iphoneX ? 88 : 64;
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, WSScreenW, WSTopTitleViewH)];
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.backgroundColor = UIColor.whiteColor;
    _topTilteScrollView = topScrollView;
    [self.view addSubview:topScrollView];
}

/**
 设置顶部标题按钮
 */
- (void)setupTopTitleButtons {
    
    // 创建多少个button
    NSUInteger count = self.childViewControllers.count;
    // 每个按钮的宽度(限制每个按钮的宽度最少为70)
    self.topTitleBtnWidth = WSScreenW / count;
    if (self.topTitleBtnWidth < 70) {
        self.topTitleBtnWidth = 70;
    }
    CGFloat btnH = _topTilteScrollView.ws_height;;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.topTitleBtnWidth*i, 0, self.topTitleBtnWidth, btnH);
        btn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        NSString *title = vc.title;
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.topTilteScrollView addSubview:btn];
        
        // 添加到按钮集合
        [self.topTitleBtnList addObject:btn];
        
        // 添加下划线
        if (i == 0) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = UIColor.redColor;
            self.underLine = view;
            // 按钮内部titleLabel尺寸还没有计算
            [btn.titleLabel sizeToFit];
            
            view.ws_height = 1.5;
            view.ws_width = btn.titleLabel.ws_width;
            view.ws_centerX = btn.ws_centerX;
            view.ws_y = _topTilteScrollView.ws_height - view.ws_height;
            [self.topTilteScrollView addSubview:view];
            
            [self titleClicked:btn];
        }
    }
}

#pragma mark - topTilteScrollView里面按钮的点击事件
- (void)titleClicked:(UIButton *)button {
    // 选中按钮
    [self selectedButton:button];
    // 点击了按钮造成collection滚动
    self.selectedButton = YES;
    // 下划线跟着一起动
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.ws_centerX = button.ws_centerX;
    }];
    
    //collectionView跟着滑动
    CGFloat offsetX = self.contentCollectionView.ws_width * button.tag;
    self.contentCollectionView.contentOffset = CGPointMake(offsetX, 0);
}

- (void)selectedButton:(UIButton *)button {
    // 顶部按钮跟随变化
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 先移除cell上的view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加子控制器的view到cell上
    UITableViewController *vc = self.childViewControllers[indexPath.item];
    vc.tableView.contentInset = UIEdgeInsetsMake(WSTopTitleViewH, 0, 0, 0);
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 当前collectionView相比之前的偏移量(可正可负)
    CGFloat offsetX = scrollView.contentOffset.x - self.collectionViewCurrentOffsetX;
    // 记录当前collectionView的偏移量X
    self.collectionViewCurrentOffsetX = scrollView.contentOffset.x;

    /** 点击按钮不移动下划线(已经移动过了) */
    if (self.isSelectedButton) { // 不移动下划线
        self.selectedButton = NO;
        return;
    } else { // 移动下划线
        // 计算下划线应该平移的X
        CGFloat underLineOffsetX = offsetX * self.topTitleBtnWidth / WSScreenW;
        // 平移
        self.underLine.ws_centerX += underLineOffsetX;

        //使用Make,它是相对于最原始的位置做的形变.(使用transform，真实的frame不会变化)
//        self.underLine.transform = CGAffineTransformMakeTranslation(offsetX, 0);
        //相对于上一次做形变
//    self.underLine.transform = CGAffineTransformTranslate(self.underLine.transform, scrollView.contentOffset.x, 0);
    }
}

// 停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.ws_width;
    UIButton *btn = self.topTitleBtnList[page];
    [self selectedButton:btn];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    WSFunc
}


#pragma mark - 按钮的点击事件
/**
 游戏按钮
 */
- (void)game {
//    WSFunc
}






- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
