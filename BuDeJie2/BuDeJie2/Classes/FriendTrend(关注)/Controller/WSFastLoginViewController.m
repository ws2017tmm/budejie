//
//  WSFastLoginViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/2.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSFastLoginViewController.h"
#import "WSFastButton.h"
#import <Masonry.h>

@interface WSFastLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (strong, nonatomic) NSMutableArray *thridBtnList;

@end

@implementation WSFastLoginViewController

- (NSMutableArray *)thridBtnList {
    if (_thridBtnList == nil) {
        _thridBtnList = [NSMutableArray array];
    }
    return _thridBtnList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupThridView];
}

- (void)setupThridView {
//    if ([WXApi isWXAppInstalled]) {
//        //判断是否有微信
//    }
//
//    if ([QQApi isQQInstalled]) {
//        //判断是否有qq
//    }
    
    // 微信
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        WSFastButton *wechatBtn = [WSFastButton buttonWithImage:[UIImage imageNamed:@"login_tecent_icon"] title:@"微信"];
        [wechatBtn addTarget:self action:@selector(weChatLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.thirdView addSubview:wechatBtn];
        
//    }
    
    // QQ
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqapi://"]]) {
        WSFastButton *qqBtn = [WSFastButton buttonWithImage:[UIImage imageNamed:@"login_QQ_icon"] title:@"QQ"];
        [qqBtn addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.thirdView addSubview:qqBtn];
//    }
    
    // 微博可以网页登录
    WSFastButton *sinaWeiboBtn = [WSFastButton buttonWithImage:[UIImage imageNamed:@"login_sina_icon"] title:@"微博"];
    [sinaWeiboBtn addTarget:self action:@selector(sinaWeiboLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdView addSubview:sinaWeiboBtn];
    
}

#pragma mark - 布局子控件
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.thirdView.subviews.count <= 1) {
        [self.thirdView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.thirdView);
        }];
    } else {
        [self.thirdView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        
        [self.thirdView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.thirdView);
        }];
    }
}


#pragma mark - 三方登录按钮点击
/**
 微信登录
 */
- (void)weChatLogin {
//    WSFunc
}

/**
 qq登录
 */
- (void)qqLogin {
//    WSFunc
}

/**
 微博登录
 */
- (void)sinaWeiboLogin {
//    WSFunc
}

@end
