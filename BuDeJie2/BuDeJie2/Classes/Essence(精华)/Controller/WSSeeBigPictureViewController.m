//
//  WSSeeBigPictureViewController.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/8.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSSeeBigPictureViewController.h"
#import "WSTopicItem.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
#import "WSPhotoTool.h"

@interface WSSeeBigPictureViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation WSSeeBigPictureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置UI
    [self setupUI];
    
    
    
}

- (void)setupUI {
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    self.saveButton.enabled = NO;
    
    // 添加 imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicItem.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.saveButton.enabled = YES;
        // 处理超长图片的大小
        if (self.topicItem.isBigPicture) {
            CGFloat imageW = WSScreenW;
            CGFloat imageH = WSScreenW / self.topicItem.width * self.topicItem.height;
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));

            // 绘制图片到上下文中
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    CGFloat imageViewH = WSScreenW / _topicItem.width * _topicItem.height;
    imageView.frame = CGRectMake(0, 0, WSScreenW, imageViewH);
    if (_topicItem.isBigPicture) { // 是超长图
        self.scrollView.contentSize = CGSizeMake(WSScreenW, imageViewH);
    } else { // 小图
        imageView.center = CGPointMake(WSScreenW * 0.5, WSScreenH * 0.5);
    }
    
    // 图片缩放
    CGFloat maxScale = self.topicItem.width / imageView.ws_width;
    if (maxScale > 1) {
        self.scrollView.maximumZoomScale = maxScale;
        self.scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - 按钮的点击事件
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture {
    // 获取当前用户权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    // 判断权限
    switch (status) {
        case PHAuthorizationStatusNotDetermined: // 用户还没有确定(第一次)
            // 系统会自动弹框弹框
            [self saveImageIntoAlbum];
            break;
        case PHAuthorizationStatusAuthorized: // 用户已经开启了权限
            // 保存图片到自定义的相册
            [self saveImageIntoAlbum];
            break;
        case PHAuthorizationStatusDenied: // 已经弹过框,但被用户拒绝(提示用户)
            // 提示用户开启权限
            // 弹框
            [self jumpToSettingUI];
            break;
        case PHAuthorizationStatusRestricted: // 用户设备问题，不能访问相册
            // 弹框提示用户
            [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            break;
            
        default:
            break;
    }
}

/**
 PHObject：资源基类，PHAsset、PHCollecton等都继承它，它包含了一个属性localIdentifier，它是唯一的，所以我们可以通过此属性来判断资源对象是否是同一个
 PHAsset：代表一个在相册中的图片或视频，它本身并不储存图片或视频资源，它存放的是metaData,需要通过PHImageManager来请求才能获取图片或视频资源。
 PHCollection：照片库中单独轻量不可变的集合对象
 PHAssetCollection：PHCollection的子类，可以通过它获取系统自带的相册信息
 PHCollectionList：既是PHCollection的子类，也是PHCollection的集合
 PHFetchResult：很像NSFetchRequest吧，它也有predicate和sortDescriptors；使用起来，它类似NSArray，可以通过遍历获取储存的各个元素；还能通过观察者模式来检测相册内容是否变化。
 */
- (void)saveImageIntoAlbum {
    
    /*
        PHPhotoLibrary : 相簿
        PHAssetCollection : 相册
        PHAssetCollectionChangeRequest : 相册请求
        PHAsset : 相片
        PHAssetChangeRequest : 相片请求
        在相簿里创建相册，将相片存入相册
    */
    [WSPhotoTool saveImage:self.imageView.image completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        }
    }];
    
}

- (void)jumpToSettingUI {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"相册权限" message:@"是否打开设置q开启相册权限?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confim = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        }
    }];
    [alertVC addAction:confim];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
