//
//  WSFastButton.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/2.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSFastButton.h"

@implementation WSFastButton

+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title {
    WSFastButton *btn = [[WSFastButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

// 上下分
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 图片的位置
    self.imageView.ws_y = 0;
    self.imageView.ws_centerX = self.ws_width * 0.5;
    
    // 标题的位置
    self.titleLabel.ws_y = self.ws_height - self.titleLabel.ws_height;
    
    // 必须先设置尺寸，再设置centerX
    [self.titleLabel sizeToFit];
    
    self.titleLabel.ws_centerX = self.ws_width * 0.5;
}

@end
