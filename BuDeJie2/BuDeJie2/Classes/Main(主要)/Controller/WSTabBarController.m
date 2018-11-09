//
//  WSTabBarController.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/20.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSTabBarController.h"
#import "WSNavigationController.h"
#import "WSEssenceViewController.h"
#import "WSNewViewController.h"
#import "WSFriendTrendViewController.h"
#import "WSMineViewController.h"


@interface WSTabBarController ()

@end

@implementation WSTabBarController


+ (void)initialize {
    if (self == [WSTabBarController class]) {
        
        UITabBarItem *tabItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        
        NSDictionary *normalDict = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                     };
        [tabItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
        
        NSDictionary *selectedDict = @{
                                     NSForegroundColorAttributeName:[UIColor blackColor]
                                     };
        [tabItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tabBar.tintColor = [UIColor orangeColor];
    
    // 添加四个主控制器
    [self addChildVC];
    
    
}

#pragma  mark - 添加四个主控制器
- (void)addChildVC {
    
    // 精华
    WSNavigationController *nav1 = [self addChildVC:[[WSEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    [self addChildViewController:nav1];
    
    // 新帖
    WSNavigationController *nav2 = [self addChildVC:[[WSNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    [self addChildViewController:nav2];
    
    // 发布
    
    
    // 关注
    WSNavigationController *nav3 = [self addChildVC:[[WSFriendTrendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:nav3];
    
    // 我
    UIStoryboard *mineStoryboard = [UIStoryboard storyboardWithName:@"mine" bundle:nil];
    WSMineViewController *mineVC = mineStoryboard.instantiateInitialViewController;
    WSNavigationController *nav4 = [self addChildVC:mineVC title:@"我" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
    [self addChildViewController:nav4];
    
    
    
}

- (WSNavigationController *)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)imageName selImage:(NSString *)selImageName {
    
    WSNavigationController *nav = [[WSNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage ws_imageOriginalWithName:selImageName];
//    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return nav;
    
}








@end
