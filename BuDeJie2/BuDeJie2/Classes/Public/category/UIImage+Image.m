//
//  UIImage+Image.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

/**
 加载一张不被渲染的图片
 
 @param imageName 原始图片
 @return 返回不被渲染的图片
 */
+ (instancetype)ws_imageOriginalWithName:(NSString *)imageName {
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


/**
 画圆形图片
 
 @return 返回x圆形图片
 */
- (instancetype)ws_circleImage {
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域;
    [path addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

/**
 画圆形图片
 
 @param name 传入的图片
 @return 返回圆形图片
 */
+ (instancetype)ws_circleImageNamed:(NSString *)name {
    return [[self imageNamed:name] ws_circleImage];
}

@end
