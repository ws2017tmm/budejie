//
//  WSFileTool.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/2.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSFileTool.h"

@implementation WSFileTool

/**
 根据路径计算文件目录的大小
 
 @param directoryPath 文件路径
 @param completion 计算完成后的回调
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(unsigned long long totalSize))completion {
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断传入的文件路径是否存在
    BOOL isExist = [mgr fileExistsAtPath:directoryPath];
    if (!isExist) { // 不存在,抛异常
        NSException *excp = [NSException exceptionWithName:@"filePathError" reason:@" 需要传入的是文件夹路径，并且路径要存在" userInfo:nil];
        @throw excp;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 文件夹总大小
        unsigned long long totalSize = 0;
        // 获取cachePath路径下所有的文件(包括文件夹和隐藏文件)
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        for (NSString *subPath in subPaths) {
            // 拼接子文件的全路径
            NSString *subFilePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断是否是隐藏文件和文件夹
            if ([subFilePath containsString:@".DS"]) continue;
            BOOL isDirectory = NO;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:subFilePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件的属性
            NSError *error;
            NSDictionary *attr = [mgr attributesOfItemAtPath:subFilePath error:&error];
            if (error) continue;
            // 计算文件大小
            unsigned long long fileSize = [attr fileSize];
            // 总大小
            totalSize += fileSize;
        }
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}

/**
 根据路径计算文件目录的大小,得到字符串(1.2M,123KB,550B)
 
 @param directoryPath 文件路径
 @param completion 计算完成后的回调
 */
+ (void)getDirectorySizeStr:(NSString *)directoryPath completion:(void(^)(NSString *sizeStr))completion {
    [self getDirectorySize:directoryPath completion:^(unsigned long long totalSize) {
        
        NSString *sizeStr = @"清除缓存";
        // MB KB B
        if (totalSize > 1000 * 1000) {
            // MB
            CGFloat sizeF = totalSize / 1000.0 / 1000.0;
            sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
        } else if (totalSize > 1000) {
            // KB
            CGFloat sizeF = totalSize / 1000.0;
            sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
        } else if (totalSize > 0) {
            // B
            sizeStr = [NSString stringWithFormat:@"%@(%lldB)",sizeStr,totalSize];
        }
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
        if (completion) {
            completion(sizeStr);
        }
    }];
}


/**
 删除一个目录
 
 @param directoryPath 目录的路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath {
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断传入的文件路径是否存在
    BOOL isExist = [mgr fileExistsAtPath:directoryPath];
    if (!isExist) { // 不存在,抛异常
        NSException *excp = [NSException exceptionWithName:@"filePathError" reason:@" 需要传入的是文件夹路径，并且路径要存在" userInfo:nil];
        @throw excp;
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
}

@end
