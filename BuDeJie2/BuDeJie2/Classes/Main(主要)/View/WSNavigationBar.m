//
//  WSNavigationBar.m
//  BuDeJie2
//
//  Created by wusheng on 2018/10/23.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WSNavigationBar.h"
#import "WSBackView.h"
#import "WSBackButton.h"

@interface WSNavigationBar()

@property (nonatomic, assign) BOOL applied;

@end

@implementation WSNavigationBar


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    if (self.applied ||[UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
        for (UIView *view in self.subviews) {
            for (UIView *subView in view.subviews) {
                if ([NSStringFromClass(subView.class) isEqualToString:@"_UIButtonBarStackView"]) {
                    for (UIView *subV in subView.subviews) {
                        for (UIView *v in subV.subviews) {
                            if ([v isKindOfClass:WSBackView.class]) {
                                
                                for (NSLayoutConstraint *constraint in subView.superview.constraints) {
                                    if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]] &&
                                        constraint.firstAttribute == NSLayoutAttributeTrailing) {
                                        [subView.superview removeConstraint:constraint];
                                    }
                                }
                                [subView.superview addConstraint:[NSLayoutConstraint constraintWithItem:subView
                                                                                           attribute:NSLayoutAttributeLeading
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:subView.superview
                                                                                           attribute:NSLayoutAttributeLeading
                                                                                          multiplier:1.0
                                                                                            constant:5]];
                                self.applied = YES;
                            }
                        }
                        
                    }
                }
            }
        }
    }else{
        for (int i=0; i<self.subviews.count; i++) {
            UIView *t_view = self.subviews[i];
            if (i==0) {
                t_view.ws_x = 5;
            }
        }
    }

}



@end
