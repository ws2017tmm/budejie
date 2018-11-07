//
//  WSBaseView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSBaseView.h"
#import "WSTopicItem.h"

@implementation WSBaseView

+ (instancetype)loadFormXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setTopicItem:(WSTopicItem *)topicItem {
    _topicItem = topicItem;
}

@end
