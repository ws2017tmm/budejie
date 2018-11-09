//
//  UIImage+Image.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Image)


/**
 加载一张不被渲染的图片

 @param imageName 原始图片
 @return 返回不被渲染的图片
 */
+ (instancetype)ws_imageOriginalWithName:(NSString *)imageName;


/**
 画圆形图片

 @return 返回x圆形图片
 */
- (instancetype)ws_circleImage;

/**
  画圆形图片

 @param name 传入的图片
 @return 返回圆形图片
 */
+ (instancetype)ws_circleImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
