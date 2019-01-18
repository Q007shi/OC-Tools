//
//  NSDate+FCCategory.h
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (FCCategory)

/** 将当前时间转换为 YYYY-MM-dd HH:mm:ss */
+ (NSString *)fc_nowDate2String;

/**
 将当前时间转换为制定格式字符串
 
 @param dateFormat 时间格式
 @return 时间字符串
 */
+ (NSString *)fc_nowDate2StirngWithDateformat:(NSString *)dateFormat;


/**
 根据 dateFormat 时间格式，将时间字符串 dateString 转换为 NSDate
 
 @param dateFormat 时间格式
 @param dateString 时间字符串
 @return date
 */
+ (instancetype)fc_parseDateWithDateformat:(NSString *)dateFormat dateString:(NSString *)dateString;
/**
 *将当前时间转换为毫秒时间戳
 */
+ (NSString *)fc_millisecondTimeStamp;

@end

