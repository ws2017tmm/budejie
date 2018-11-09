//
//  WSTopicItem.m
//  BuDeJie2
//
//  Created by 李响 on 2018/11/6.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSTopicItem.h"
#import "NSDate+Extension.h"

@implementation WSTopicItem

- (NSString *)passtime {
    //当前时间
    NSDate *currentDate = [NSDate date];
    
    //微博创建时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_passtime];
    
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //需要获得的参数(年月日时分秒)
    NSCalendarUnit uint = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //两个日期之间的比较(相差--年月日时分秒)
    NSDateComponents *cmps = [calendar components:uint fromDate:createDate toDate:currentDate options:0];
    
    if ([createDate isThisYear]) { //今年
        if ([createDate isToday]) { //今天
            if (cmps.hour >= 1) { //xx小时前
                return [NSString stringWithFormat:@"%d小时前",cmps.hour];
            } else if (cmps.minute > 1) { //xx分钟前
                return [NSString stringWithFormat:@"%d分钟前",cmps.minute];
            } else{
                return @"刚刚";
            }
        }else if ([createDate isYesterday]) { //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { //其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

@end
