//
//  NSString+CFCategory.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "NSString+CFCategory.h"

@implementation NSString (CFCategory)

/** 字符串是否为空 */
- (BOOL)fc_isEmpty{
    return self == nil || self.length == 0;
}

//根据正则表达式字符串 regex 将 sourceString 截取，并将截取结果返回
- (NSArray<NSTextCheckingResult *> *)fc_trimSourceStringWithRegex:(NSString *)regex{
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        return nil;
    }else{
        if (self) {
            return [re matchesInString:self options:0 range:NSMakeRange(0, self.length)];
        }else{
            return nil;
        }
    }
}

//对当前字符，根据正则表达式 regex 进行匹配
- (BOOL)fc_evaluateWithRegex:(nonnull NSString *)regex{
    if (self.fc_isEmpty || regex.fc_isEmpty) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
