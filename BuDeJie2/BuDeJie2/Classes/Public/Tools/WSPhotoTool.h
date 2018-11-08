//
//  WSPhotoTool.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//  处理图片

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSPhotoTool : NSObject

/**
 保存图片到指定的相册

 @param image 需要保存的图片
 @param albumName 相册的名称
 */
+ (void)saveImage:(UIImage *)image albumTitle:(NSString *)albumName  completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler;


/**
 保存图片到相册

 @param image 需要保存的图片(默认创建和app同名的相册)
 */
+ (void)saveImage:(UIImage *)image completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
