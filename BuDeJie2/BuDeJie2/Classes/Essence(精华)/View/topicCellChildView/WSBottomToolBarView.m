//
//  WSBottomToolBarView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSBottomToolBarView.h"
#import "WSTopicItem.h"

@interface WSBottomToolBarView ()

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation WSBottomToolBarView

- (void)setTopicItem:(WSTopicItem *)topicItem {
    [super setTopicItem:topicItem];
    
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topicItem.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topicItem.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton number:topicItem.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topicItem.comment placeholder:@"评论"];
    
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}


@end
