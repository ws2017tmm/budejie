//
//  WSMiddleVideoView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSMiddleVideoView.h"
#import "WSTopicItem.h"
#import <UIImageView+WebCache.h>

@interface WSMiddleVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation WSMiddleVideoView

- (void)setTopicItem:(WSTopicItem *)topicItem {
    [super setTopicItem:topicItem];
    self.placeholderView.hidden = NO;
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    [self.imageView ws_setOriginImage:topicItem.image1 thumbnailImage:topicItem.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) return;
        self.placeholderView.hidden = YES;
    }];
    
    // 播放数量
    if (topicItem.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topicItem.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topicItem.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topicItem.videotime / 60, topicItem.videotime % 60];
}

@end
