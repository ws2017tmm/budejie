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


+ (unsigned long long)getDirectorySize:(NSString *)directoryPath;

+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end

NS_ASSUME_NONNULL_END