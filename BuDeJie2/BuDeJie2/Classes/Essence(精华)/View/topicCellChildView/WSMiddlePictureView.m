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
#import <DALabeledCircularProgressView.h>
#import "WSSeeBigPictureViewController.h"

@interface WSMiddlePictureView ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
// 查看大图
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureBtn;
// 进度条
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation WSMiddlePictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.imageView.userInteractionEnabled = YES;
//    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    
    self.progressView.trackTintColor = UIColor.clearColor;
    self.progressView.progressTintColor = UIColor.whiteColor;
    self.progressView.roundedCorners = YES;
}
/**
 *  查看大图
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WSSeeBigPictureViewController *vc = [[WSSeeBigPictureViewController alloc] init];
    vc.topicItem = self.topicItem;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];

}
//- (void)seeBigPicture
//{
//    WSSeeBigPictureViewController *vc = [[WSSeeBigPictureViewController alloc] init];
//    vc.topic = self.topic;
//    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
//
//}

- (void)setTopicItem:(WSTopicItem *)topicItem {
    [super setTopicItem:topicItem];
    
    self.progressView.hidden = NO;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0] placeholderImage:[UIImage imageNamed:@"imageBackground"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress >= 1) {
                self.progressView.hidden = YES;
                self.progressView.progress = 0;
                self.progressView.progressLabel.text = @"";
            } else {
                self.progressView.progress = progress;
                self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.f%%",progress*100];
            }
        });
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    
    self.gifImageView.hidden = !topicItem.is_gif;
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
