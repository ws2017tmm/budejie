//
//  WSNavigationController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSNavigationController.h"
#import "WSNavigationBar.h"
#import "WSBackView.h"
#import "WSBackButton.h"
#import <objc/runtime.h>

@interface WSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WSNavigationController

#pragma mark - 全局导航栏属性的设置
+ (void)initialize {
    if (self == [WSNavigationController class]) {
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        // 只要是通过模型设置,都是通过富文本设置
        // 设置导航条标题 => UINavigationBar
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
        [navBar setTitleTextAttributes:attrs];
        
        // 设置导航条背景图片
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WSNavigationBar *navBar = [[WSNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    [self setValue:navBar forKey:@"navigationBar"];
    
    
    //  self.interactivePopGestureRecognizer =  <UIScreenEdgePanGestureRecognizer: 0x7fa257426180; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fa25741a5f0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fa257426040>)>>
    
    //    self.interactivePopGestureRecognizer.delegate = _UINavigationInteractiveTransition
    
    // 禁止以前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    // 添加新的全屏滑动手势
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    self.interactivePopGestureRecognizer.delegate = self;
//    NSLog(@"---%@",self.interactivePopGestureRecognizer);
//    NSLog(@"---%@",object_getClass(self.interactivePopGestureRecognizer.delegate));
}

#pragma mark - UIGestureRecognizerDelegate
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 全局统一的返回按钮
        WSBackView *backView = [WSBackView backViewWithTarget:self selector:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}







@end
