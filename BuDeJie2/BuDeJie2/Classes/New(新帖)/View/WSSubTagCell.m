//
//  WSSubTagCell.m
//  BuDeJie2
//
//  Created by 李响 on 2018/10/31.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSSubTagCell.h"
#import <UIImageView+WebCache.h>
#import "WSSubTagItem.h"

@interface WSSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end


@implementation WSSubTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSubTagItem:(WSSubTagItem *)subTagItem {
    _subTagItem = subTagItem;
    
    NSLog(@"%.2f",_iconImageView.ws_height);
//    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.iconImageView.layer.cornerRadius = self.iconImageView.ws_height * 0.5;
        self.iconImageView.layer.masksToBounds = YES;
    }];
    // 设置内容
    _titleLabel.text = subTagItem.theme_name;
    // 判断下有没有>10000
    [self resolveNum];
}

// 处理订阅数字
- (void)resolveNum
{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_subTagItem.sub_number] ;
    NSInteger num = _subTagItem.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numberLabel.text = numStr;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    // 才是真正去给cell赋值
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.iconImageView.layer.cornerRadius = self.iconImageView.ws_width * 0.5;
//    self.iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
