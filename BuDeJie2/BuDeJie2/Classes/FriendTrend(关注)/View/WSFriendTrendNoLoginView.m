//
//  WSFriendTrendNoLoginView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/10/31.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSFriendTrendNoLoginView.h"

@interface WSFriendTrendNoLoginView ()



@end

@implementation WSFriendTrendNoLoginView

+ (instancetype)loadFormXib {
    return [[[NSBundle mainBundle] loadNibNamed:@"WSFriendTrendNoLoginView" owner:nil options:nil] firstObject];
}

// 点击注册登录按钮
- (IBAction)registerLoginBtnClicked {
    
    if (self.registerLoginBtnClick) {
        self.registerLoginBtnClick();
    }
    
}


@end
