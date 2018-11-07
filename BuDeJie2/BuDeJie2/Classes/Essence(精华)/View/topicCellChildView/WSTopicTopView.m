//
//  WSTopicTopView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/6.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSTopicTopView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "WSTopicItem.h"


@interface WSTopicTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation WSTopicTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子控件
//        [self setupUI];
//        // 设置约束
//        [self setupMasonry];
    }
    return self;
}

- (void)setupUI {
    // 头像
    UIImageView *headImageView = [[UIImageView alloc] init];
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    // 必须写
    self.contentLabel.preferredMaxLayoutWidth = WSScreenW-24;
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)setupMasonry {
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.width.height.mas_equalTo(WSMargin(50));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headImageView.mas_bottom).offset(2);
        make.left.mas_equalTo(self.headImageView.mas_right).offset(5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-8);
    }];
}

- (void)setTopicItem:(WSTopicItem *)topicItem {
    [super setTopicItem:topicItem];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image]];
    self.nameLabel.text = topicItem.name;
    self.timeLabel.text = topicItem.passtime;
    self.contentLabel.text = topicItem.text;
    
//    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    
//    CGFloat cellHeight = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
//    _topicItem.cellHeight = cellHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
