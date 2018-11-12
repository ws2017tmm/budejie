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
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation WSMiddlePictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.imageView.userInteractionEnabled = YES;
//    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    
    self.progressView.trackTintColor = WSColor(210, 210, 210);
    self.progressView.progressTintColor = UIColor.whiteColor;
    self.progressView.roundedCorners = YES;
}
/**
 *  查看大图
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
    
    self.placeholderView.hidden = NO;
    NSString *thumbnailImage;
    if (topicItem.is_gif) {
        thumbnailImage = topicItem.gifFistFrame;
    } else {
        thumbnailImage = topicItem.image0;
    }
    
    self.progressView.hidden = NO;
    [self.imageView ws_setOriginImage:topicItem.image1 thumbnailImage:thumbnailImage placeholder:[UIImage imageNamed:@"mainCellBackground"] progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.f%%",progress*100];
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) return;
        self.placeholderView.hidden = YES;
        
        self.progressView.progress = 0;
        self.progressView.progressLabel.text = @"";
        self.progressView.hidden = YES;
        
        // 处理超长图片的大小
        if (topicItem.isBigPicture) {
            CGFloat imageW = topicItem.middleFrame.size.width;
            CGFloat imageH = imageW * topicItem.height / topicItem.width;
            
            // 开启上下文
//            UIGraphicsBeginImageContextWithOptions(topicItem.middleFrame.size, YES, 0.0);
            UIGraphicsBeginImageContext(topicItem.middleFrame.size);
//            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
        
    }];
    
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
