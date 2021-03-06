//
//  NSDate+FCCategory.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "NSDate+FCCategory.h"

@implementation NSDate (FCCategory)

//将当前时间转换为 YYYY-MM-dd HH:mm:ss
+ (NSString *)fc_nowDate2String{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];//东八区，北京时间
    [dateFormatter setCalendar: [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    return  [dateFormatter stringFromDate:[NSDate date]];
}

//将当前时间转换为制定格式字符串
+ (NSString *)fc_nowDate2StirngWithDateformat:(NSString *)dateFormat{
    if (dateFormat.fc_isEmpty){ return @""; }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = dateFormat;
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];//东八区，北京时间
    [dateFormatter setCalendar: [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    return  [dateFormatter stringFromDate:[NSDate date]];
}

//根据 dateFormat 时间格式，将时间字符串 dateString 转换为 NSDate
+ (instancetype)fc_parseDateWithDateformat:(NSString *)dateFormat dateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = dateFormat;
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];//东八区，北京时间
    [dateFormatter setCalendar: [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    return [dateFormatter dateFromString:dateString];
}
//将当前时间转换为毫秒时间戳
+ (NSString *)fc_millisecondTimeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]*1000;//*1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
//将当前 Date 转换为毫秒时间戳
- (NSString *)fc_millisecondTimeStamp{
    NSString *timeString = @"0";
    if (self) {
        NSTimeInterval time=[self timeIntervalSince1970]*1000;//*1000 是精确到毫秒，不乘就是精确到秒
        timeString = [NSString stringWithFormat:@"%.0f", time];
    }
    return timeString;
}

@end
