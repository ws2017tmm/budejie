//
//  WSTopicFrameItem.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/7.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSTopicFrameItem.h"
#import "WSTopicItem.h"

@implementation WSTopicFrameItem

- (void)setTopicItem:(WSTopicItem *)topicItem {
    _topicItem = topicItem;
    
    /**--------------顶部view---------------*/
    CGFloat margin = 10;
    // 计算顶部view的frame
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = WSScreenW;
    //计算正文高度
    CGFloat contentLabelY = WSMargin(50) + margin;
    
    NSDictionary *attrDict = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:15]
                               };
    CGFloat contentLabelH = [topicItem.text boundingRectWithSize:CGSizeMake(WSScreenW-margin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size.height;
     CGFloat topViewH = contentLabelY + contentLabelH;
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    _cellHeight = CGRectGetMaxY(_topViewFrame) + margin;
    
    /**--------------中间view---------------*/
    if (topicItem.type != WSTopicTypeWord) {
        // 图片的frame
        CGFloat pictureViewX = margin;
        CGFloat pictureViewY = _cellHeight + margin;
        CGFloat pictureViewW = WSScreenW - margin*2;
        // 计算pictureView高度
        CGFloat pictureViewH = topicItem.height * pictureViewW / topicItem.width;
        if (pictureViewH > WSScreenH) {
            pictureViewH = 250;
            topicItem.bigPicture = YES;
        }
        _middleFrame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        topicItem.middleFrame = _middleFrame;
        _cellHeight = CGRectGetMaxY(_middleFrame) + margin;
    }
    
    /**--------------底部view---------------*/
    // 图片的frame
    CGFloat toolBarX = 0;
    CGFloat toolBarY = _cellHeight;
    CGFloat toolBarW = WSScreenW;
    CGFloat toolBarH = 35;
    _bottomFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _cellHeight = CGRectGetMaxY(_bottomFrame) + margin*2;
    
}

@end
