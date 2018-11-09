//
//  NSDate+Extension.h
//  BuDeJie2
//
//  Created by 李响 on 2018/11/9.
//  Copyright © 2018 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

/** 判断是否为今年 */
- (BOOL)isThisYear;

/** 判断是否为今天 */
- (BOOL)isToday;

/** 判断是否为昨天 */
- (BOOL)isYesterday;

@end

NS_ASSUME_NONNULL_END
