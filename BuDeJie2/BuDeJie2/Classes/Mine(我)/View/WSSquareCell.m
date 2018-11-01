//
//  WSSquareCell.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/1.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSSquareCell.h"
#import <UIImageView+WebCache.h>
#import "WSSquareItem.h"

@interface WSSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation WSSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSquareItem:(WSSquareItem *)squareItem {
    _squareItem = squareItem;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:squareItem.icon]];
    self.titleLabel.text = squareItem.name;
}

@end
