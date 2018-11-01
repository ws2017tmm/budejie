//
//  WSRegisterLoginView.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/1.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSRegisterLoginView.h"

@interface WSRegisterLoginView ()

@property (weak, nonatomic) IBOutlet UIButton *registerLoginBtn;


@end

@implementation WSRegisterLoginView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *image = self.registerLoginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    // 让按钮背景图片不要被拉伸
    [self.registerLoginBtn setBackgroundImage:image forState:UIControlStateNormal];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
