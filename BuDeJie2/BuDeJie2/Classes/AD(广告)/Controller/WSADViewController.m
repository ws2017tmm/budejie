//
//  WSADViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/10/31.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSADViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "WSADItem.h"
#import "WSTabBarController.h"


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"



@interface WSADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lunchImage;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (weak, nonatomic) UIImageView *adImageView;
@property (strong, nonatomic) WSADItem *adItem;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation WSADViewController

#pragma mark - 懒加载广告视图
- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd)];
        [imageView addGestureRecognizer:tap];
        
        [self.adContainView addSubview:imageView];
        _adImageView = imageView;
        
    }
    return _adImageView;
}

// 点击广告界面调用
- (void)tapAd
{
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
//            UIApplicationOpenURLOptionsAnnotationKey
//            UIApplicationOpenURLOptionsOpenInPlaceKey
        }];
    }
}

#pragma mark - 跳过
- (IBAction)jump:(id)sender {
    
    WSTabBarController *tabVC = [[WSTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
    
    // 销毁定时器
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载广告数据
    [self loadAdData];
    
    // 定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

#pragma mark - 设置启动图片
- (void)setupLaunchImage {
    if (iphoneX) {
        self.lunchImage.image = [UIImage imageNamed:@"<#string#>"];
    } else if (iphone6P) {
        self.lunchImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) {
        self.lunchImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) {
        self.lunchImage.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iphone4) {
        self.lunchImage.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

#pragma mark - 加载广告数据
- (void)loadAdData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager ws_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%lld,%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary   * _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/lixiang041/Desktop/plist/ad.plist" atomically:YES];
//        NSLog(@"responseObject = %@",responseObject);
        
        // 解析数据(字典转模型)
        self.adItem = [WSADItem mj_objectWithKeyValues:[responseObject[@"ad"] firstObject]];
        
        // 根据返回图片的宽高设置图片的尺寸
        CGFloat h;
        if (self.adItem.w <= 0) {
            h = WSScreenH;
        } else {
            h = WSScreenW / self.adItem.w * self.adItem.h;
        }
        self.adImageView.frame = CGRectMake(0, 0, WSScreenW, h);
        // 设置图片
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:self.adItem.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
    }];
    
}

#pragma mark - 倒计时3秒
- (void)countDown {
    static int count = 3;
    
    if (count == -1) {
        [self jump:nil];
    }
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%i)",count] forState:UIControlStateNormal];
    count-- ;
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
