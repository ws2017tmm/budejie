//
//  WSTopicFrameItem.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WSTopicItem;

NS_ASSUME_NONNULL_BEGIN

@interface WSTopicFrameItem : NSObject

@property (strong, nonatomic) WSTopicItem *topicItem;

/** 顶部view的frame */
@property (assign, nonatomic) CGRect topViewFrame;
/** 中间图片view的frame */
@property (assign, nonatomic) CGRect pictureFrame;



/** 该Model对应的Cell高度 */
@property (assign, nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
