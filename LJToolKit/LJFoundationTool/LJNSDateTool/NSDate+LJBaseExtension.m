//
//  NSDate+LJBaseExtension.m
//  FoundationDemo
//
//  Created by 宋立军 on 2017/5/11.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "NSDate+LJBaseExtension.h"
#import <objc/runtime.h>

@implementation NSDate (LJBaseExtension)

const long long SECONDS_IN_YEAR = 31556900;
const NSInteger SECONDS_IN_MONTH_28 = 2419200;
const NSInteger SECONDS_IN_MONTH_29 = 2505600;
const NSInteger SECONDS_IN_MONTH_30 = 2592000;
const NSInteger SECONDS_IN_MONTH_31 = 2678400;
const NSInteger SECONDS_IN_WEEK = 604800;
const NSInteger SECONDS_IN_DAY = 86400;
const NSInteger SECONDS_IN_HOUR = 3600;
const NSInteger SECONDS_IN_MINUTE = 60;
const NSInteger MILLISECONDS_IN_DAY = 86400000;

- (NSInteger)lj_year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)lj_month {
    [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self].month = 1;
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)lj_day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)lj_hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)lj_minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)lj_second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)lj_nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)lj_weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSString *)lj_ymdFormat {
    return @"yyyy-MM-dd";
}

- (NSString *)lj_hmsFormat {
    return @"HH:mm:ss";
}

- (NSString *)lj_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self lj_ymdFormat], [self lj_hmsFormat]];
}
    
- (NSString *)lj_dayFromWeekday {
    
    NSInteger weekDay = [[[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self] weekday];
    
    switch (weekDay) {
        case 1:
        return @"星期天";
        break;
        
        case 2:
        return @"星期一";
        break;
        
        case 3:
        return @"星期二";
        break;
        
        case 4:
        return @"星期三";
        break;
        
        case 5:
        return @"星期四";
        break;
        
        case 6:
        return @"星期五";
        break;
        
        case 7:
        return @"星期六";
        break;
        
        default:
        break;
    }
    return @"";
}
    
@end
