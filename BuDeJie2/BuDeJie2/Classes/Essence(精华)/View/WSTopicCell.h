//
//  WSTopicCell.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/6.
//  Copyright © 2018 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class WSTopicItem;
@class WSTopicFrameItem;

NS_ASSUME_NONNULL_BEGIN

@interface WSTopicCell : UITableViewCell

@property (strong, nonatomic) WSTopicFrameItem *topicFrameItem;
//- (CGFloat)heightForTopicItem:(WSTopicItem *)topicItem;

@end

NS_ASSUME_NONNULL_END
