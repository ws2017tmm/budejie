//
//  WSMiddlePictureView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSMiddlePictureView.h"
#import "WSTopicItem.h"
#import <UIImageView+WebCache.h>

@interface WSMiddlePictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;

@end

@implementation WSMiddlePictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}
/**
 *  查看大图
 */
- (void)seeBigPicture
{
//    WSSeeBigPictureViewController *vc = [[WSSeeBigPictureViewController alloc] init];
//    vc.topic = self.topic;
//    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

- (void)setTopicItem:(WSTopicItem *)topicItem {
    [super setTopicItem:topicItem];
    
    self.gifImageView.hidden = !topicItem.is_gif;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    
    if (topicItem.isBigPicture) { // 超长图
        self.seeBigPictureBtn.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureBtn.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}


@end
