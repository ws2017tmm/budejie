//
//  WSTopicItem.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/6.
//  Copyright © 2018 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WSTopicType) {
    /** 全部 */
    WSTopicTypeAll = 1,
    /** 图片 */
    WSTopicTypePicture = 10,
    /** 段子 */
    WSTopicTypeWord = 29,
    /** 声音 */
    WSTopicTypeVoice = 31,
    /** 视频 */
    WSTopicTypeVideo = 41
};

NS_ASSUME_NONNULL_BEGIN

@interface WSTopicItem : NSObject

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) WSTopicType type;


/** -----------------顶部view------------------- **/
/** 用户的头像 */
@property (strong, nonatomic) NSString *profile_image;
/** 用户的名字 */
@property (strong, nonatomic) NSString *name;
/** 帖子审核通过的时间 */
@property (strong, nonatomic) NSString *passtime;
/** 帖子的文字内容 */
@property (strong, nonatomic) NSString *text;

/** -----------------中间view------------------- **/
      /** -------------图片--------------- **/
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 是否为动图 */
@property (nonatomic, assign) BOOL is_gif;
/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;

      /** -------------视频\音频--------------- **/
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** -----------------底部view------------------- **/
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;


/* 额外增加的属性（非服务器返回的属性）*/
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;

@end

NS_ASSUME_NONNULL_END
