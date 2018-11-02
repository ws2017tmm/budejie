//
//  WSFileTool.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/2.
//  Copyright © 2018 ws. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFileTool : NSObject



/**
 根据路径计算文件目录的大小

 @param directoryPath 文件路径
 @param completion 计算完成后的回调
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(unsigned long long totalSize))completion;


/**
 删除一个目录

 @param directoryPath 目录的路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end

NS_ASSUME_NONNULL_END
