//
//  WSADItem.h
//  BuDeJie2
//
//  Created by 李响 on 2018/10/31.
//  Copyright © 2018 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSADItem : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;
/** 广告图片宽 */
@property (nonatomic, assign) CGFloat w;
/** 广告图片高 */
@property (nonatomic, assign) CGFloat h;

@end

NS_ASSUME_NONNULL_END
