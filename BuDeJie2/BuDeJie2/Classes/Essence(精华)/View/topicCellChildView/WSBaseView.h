//
//  WSBaseView.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTopicItem;

NS_ASSUME_NONNULL_BEGIN

@interface WSBaseView : UIView

+ (instancetype)loadFormXib;
@property (strong, nonatomic) WSTopicItem *topicItem;


@end

NS_ASSUME_NONNULL_END
