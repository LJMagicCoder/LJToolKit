//
//  NSDate+LJBaseExtension.h
//  FoundationDemo
//
//  Created by 宋立军 on 2017/5/11.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LJBaseExtension)

FOUNDATION_EXPORT const long long SECONDS_IN_YEAR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_28;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_29;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_30;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MONTH_31;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_WEEK;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_DAY;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_HOUR;
FOUNDATION_EXPORT const NSInteger SECONDS_IN_MINUTE;
FOUNDATION_EXPORT const NSInteger MILLISECONDS_IN_DAY;

/*!
 @brief      年
 */
@property (nonatomic, readonly) NSInteger lj_year;

/*!
 @brief      月
 */
@property (nonatomic, readonly) NSInteger lj_month;

/*!
 @brief      日
 */
@property (nonatomic, readonly) NSInteger lj_day;

/*!
 @brief      星期
 */
@property (nonatomic, readonly) NSInteger lj_weekday;

/*!
 @brief      时
 */
@property (nonatomic, readonly) NSInteger lj_hour;

/*!
 @brief      分
 */
@property (nonatomic, readonly) NSInteger lj_minute;

/*!
 @brief      秒
 */
@property (nonatomic, readonly) NSInteger lj_second;

/*!
 @brief      毫秒
 */
@property (nonatomic, readonly) NSInteger lj_nanosecond;

/**
 @brief      获取yyyy-MM-dd格式的字符串
 @return     yyyy-MM-dd
 */
- (NSString *)lj_ymdFormat;

/**
 @brief      获取HH:mm:ss格式的字符串
 @return     HH:mm:ss
 */
- (NSString *)lj_hmsFormat;

/**
 @brief      获取yyyy-MM-dd HH:mm:ss格式的字符串
 @return     yyyy-MM-dd HH:mm:ss
 */
- (NSString *)lj_ymdHmsFormat;

/**
 *  获取星期几(名称)(汉语)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)lj_dayFromWeekday;

@end
