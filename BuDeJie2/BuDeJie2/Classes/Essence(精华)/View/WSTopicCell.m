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
#import "WSMiddleVideoView.h"
#import "WSMiddleVoiceView.h"
#import "WSBottomToolBarView.h"

@interface WSTopicCell ()

@property (weak, nonatomic) WSTopicTopView *topView;
@property (weak, nonatomic) WSMiddlePictureView *pictureView;
@property (weak, nonatomic) WSMiddleVideoView *videoView;
@property (weak, nonatomic) WSMiddleVoiceView *voiceView;
@property (weak, nonatomic) WSBottomToolBarView *toolBarView;

@end

@implementation WSTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /**--------------顶部view--------------*/
        // (包括头像，昵称，时间，正文)
        WSTopicTopView *topView = [WSTopicTopView loadFormXib];
        [self.contentView addSubview:topView];
        self.topView = topView;
        
        /**--------------中间View--------------*/
        // 图片
        WSMiddlePictureView *pictureView = [WSMiddlePictureView loadFormXib];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
        // 视频
        WSMiddleVideoView *videoView = [WSMiddleVideoView loadFormXib];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
        
        // 声音
        WSMiddleVoiceView *voiceView = [WSMiddleVoiceView loadFormXib];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
        
        /**--------------底部工具条View--------------*/
        WSBottomToolBarView *toolBarView = [WSBottomToolBarView loadFormXib];
        [self.contentView addSubview:toolBarView];
        self.toolBarView = toolBarView;
    }
    return self;
}

- (void)setTopicFrameItem:(WSTopicFrameItem *)topicFrameItem {
    _topicFrameItem = topicFrameItem;
    WSTopicItem *topicItem = topicFrameItem.topicItem;
    
    // 顶部
    self.topView.topicItem = topicItem;
    
    // 中间
    if (topicItem.type == WSTopicTypePicture) { // 图片
        self.pictureView.topicItem = topicItem;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topicItem.type == WSTopicTypeVideo) { // 视频
        self.videoView.topicItem = topicItem;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topicItem.type == WSTopicTypeVoice) { // 声音
        self.voiceView.topicItem = topicItem;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topicItem.type == WSTopicTypeWord) { // 段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    // 底部
    self.toolBarView.topicItem = topicItem;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topView.frame = self.topicFrameItem.topViewFrame;
    
    self.pictureView.frame = self.topicFrameItem.middleFrame;
    self.videoView.frame = self.topicFrameItem.middleFrame;
    self.voiceView.frame = self.topicFrameItem.middleFrame;
    self.toolBarView.frame = self.topicFrameItem.bottomFrame;
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
