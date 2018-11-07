//
//  WSTopicCell.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/6.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSTopicCell.h"
#import "WSTopicFrameItem.h"
#import "WSTopicItem.h"
//#import <Masonry.h>
#import "WSTopicTopView.h"
#import "WSMiddlePictureView.h"

@interface WSTopicCell ()

@property (weak, nonatomic) WSTopicTopView *topView;
@property (weak, nonatomic) WSMiddlePictureView *pictureView;

@end

@implementation WSTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 顶部view(包括头像，昵称，时间，正文)
        WSTopicTopView *topView = [WSTopicTopView loadFormXib];
        [self.contentView addSubview:topView];
        self.topView = topView;
        
        /**--------------中间View--------------*/
        // 图片
        WSMiddlePictureView *pictureView = [WSMiddlePictureView loadFormXib];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        // 视频
        
        // 声音
        
        
        
    }
    return self;
}

- (void)setTopicFrameItem:(WSTopicFrameItem *)topicFrameItem {
    _topicFrameItem = topicFrameItem;
    
    self.topView.topicItem = topicFrameItem.topicItem;
    self.pictureView.topicItem = topicFrameItem.topicItem;
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topView.frame = self.topicFrameItem.topViewFrame;
    self.pictureView.frame = self.topicFrameItem.pictureFrame;
    
}


//- (CGFloat)heightForTopicItem:(WSTopicItem *)topicItem {
//    [self setTopicItem:topicItem];
//
//    [self layoutIfNeeded];
//    CGFloat cellHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
//    topicItem.cellHeight = cellHeight;
//    return topicItem.cellHeight;
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
