//
//  UIImageView+Download.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//  根据网络状态下载图片(缩略图，高清图)

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Download)


/**
 根据网络状态下载图片

 @param originImageURL 高清图片
 @param thumbnailImageURL 缩略图
 @param placeholder 占位图片
 @param progressBlock 进度
 @param completedBlock 回调
 */
- (void)ws_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(nullable UIImage *)placeholder progress:(nullable SDImageLoaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock;

/**
 根据网络状态下载图片
 
 @param originImageURL 高清图片
 @param thumbnailImageURL 缩略图
 @param placeholder 占位图片
 @param completedBlock 回调
 */
- (void)ws_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(nullable UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;

/**
 下载头像，画圆形

 @param headerUrl 头像地址
 */
- (void)ws_setHeader:(NSString *)headerUrl;

@end

NS_ASSUME_NONNULL_END
