//
//  UIImageView+Download.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//

#import "UIImageView+Download.h"
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+WebCache.h>
#import <SDWebImage.h>

@implementation UIImageView (Download)

/**
 根据网络状态下载图片
 
 @param originImageURL 高清图片
 @param thumbnailImageURL 缩略图
 @param placeholder 占位图片
 @param completedBlock 回调
 */
- (void)ws_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(nullable UIImage *)placeholder progress:(nullable SDImageLoaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock {
    
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    
    if (originImage) { // 原图被下载过
        [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
    } else { // 原图没有被下载过
        // 判断网络状态
        if (mgr.isReachableViaWiFi) { // 当前是WiFi
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) { // 手机自带网络
            // 3G\4G网络的时候是否要下载原图(假设需要下载)
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder options:SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
            }
        } else { // 没有可用的网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            } else { // 没有下载过任何图片
                // 占位图片;
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
            }
        }
    }
}

/**
 根据网络状态下载图片
 
 @param originImageURL 高清图片
 @param thumbnailImageURL 缩略图
 @param placeholder 占位图片
 @param completedBlock 回调
 */
- (void)ws_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(nullable UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock {
    [self ws_setOriginImage:originImageURL thumbnailImage:thumbnailImageURL placeholder:placeholder progress:nil completed:completedBlock];
}

/**
 下载头像，画圆形
 
 @param headerUrl 头像地址
 */
- (void)ws_setHeader:(NSString *)headerUrl {
    UIImage *placeholder = [UIImage ws_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.image = [image ws_circleImage];
    }];
}


@end
