//
//  WSPhotoTool.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSPhotoTool.h"
#import <Photos/Photos.h>

// 获取应用名作为自定义相册名
#define WSAlbumName [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]


@implementation WSPhotoTool

+ (void)saveImage:(UIImage *)image completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler {
    [self saveImage:image albumTitle:WSAlbumName completionHandler:completionHandler];
}

+ (void)saveImage:(UIImage *)image albumTitle:(NSString *)albumName completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error))completionHandler {
    
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = [self createdAssetsWithImage:image];
    if (createdAssets == nil) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"保存图片失败！", NSLocalizedDescriptionKey,nil];
         NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo];
        if (completionHandler) {
            completionHandler(NO,error);
        }
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"创建或者获取相册失败！", NSLocalizedDescriptionKey,nil];
        NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo];
        if (completionHandler) {
            completionHandler(NO,error);
        }
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionHandler) {
                completionHandler(success,error);
            }
        });
    }];
    
}

// 获取自定义相册
+ (PHAssetCollection *)createdCollection {
    // 获得软件名字(相册的名称)
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 判断是否创建过自定义相册
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    // 创建一个【自定义相册】
    NSError *error;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相册
        PHAssetCollectionChangeRequest *assetCollection = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        
        // 获取相册唯一标识
        createdCollectionID = assetCollection.placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    
    PHFetchResult<PHAssetCollection *> *localCollections = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil];
    PHAssetCollection *collection = localCollections.firstObject;
    return collection;
}

+ (PHFetchResult <PHAsset *> *)createdAssetsWithImage:(UIImage *)image {
    
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 保存图片到【相机胶卷】
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        // 相片的唯一标识
        assetID = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
        
    } error:&error];
    
    PHFetchResult <PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
    return assets;
}


@end
